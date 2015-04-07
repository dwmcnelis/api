# app/models/user.rb

# User
#

require 'token'

class User < ActiveRecord::Base

  include Concerns::GenderEnum

  enum gender: gender_enum

  has_one :credential
  has_many :clients
  has_many :teams
  has_many :tags

  class << self

    # Search by username, first or last name
    #
    # @param [String] query
    #
    # @return [ActiveRecord_Relation] scope
    #    
    def search(query)
      query = "%#{query}%"
      username = arel_table[:username].matches(query)
      first_name = arel_table[:first_name].matches(query)
      last_name = arel_table[:last_name].matches(query)
      where(username.or(first_name).or(last_name))
    end

    # Find by username/password (authenticated)
    #
    # @param [String] username
    # @param [String] password
    #
    # @return [User] user or nil
    #
    def find_by_username_password(username, password)
      User.find_by_username(username).try(:credential).try(:authenticate_by_password, password).try(:user)
    end

    # Find by token (validated)
    #
    # @param [String] token
    #
    # @return [User] user or nil
    #
    def find_by_token(encoded)
      token = Token.new(encoded: encoded)
      if token.valid?
        uid = token.payload[:uid] if token.payload
        User.find_by_id(uid)
      end
    end

  end # class << self

  def is_valid?
    !self.banned? && self.tos?
  end

  def generate_token(options={})
    expires ||= options[:expires]
    Token.new(payload: {'uid' => self.id.to_s}, expires: expires)
  end

  # Boolean methods
  #
  [:admin, :alpha, :beta, :banned, :tos].each do |symbol|
    define_method "#{symbol}?" do
      self.send(symbol) == 1 ? true : false
    end
  end

end

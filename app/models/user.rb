# app/models/user.rb

require 'token'

class User < ActiveRecord::Base

  enum gender: { male: 0, female: 1, unknown: 2}


  has_one :credential
  has_many :clients

  class << self
    def search(query)
      query = "%#{query}%"
      username = arel_table[:username].matches(query)
      first_name = arel_table[:first_name].matches(query)
      last_name = arel_table[:last_name].matches(query)
      where(username.or(first_name).or(last_name))
    end

    def find_by_username_password(username, password)
      User.find_by_username(username).try(:credential).try(:authenticate_by_password, password).try(:user)
    end

    def find_by_token(encoded)
      token = Token.new(encoded: encoded)
      if token.valid?
        uid = token.payload[:uid] if token.payload
        User.find_by_id(uid)
      end
    end

  end # class << self

  def valid?
    !self.banned? && self.tos?
  end

  def generate_token(options={})
    expires ||= options[:expires]
    Token.new(payload: {'uid' => self.id.to_s}, expires: expires)
  end

  [:admin, :alpha, :beta, :banned, :tos].each do |symbol|
    define_method "#{symbol}?" do
      self.send(symbol) == 1 ? true : false
    end
  end

end

require 'token'

class User < ActiveRecord::Base

  enum gender: { male: 0, female: 1, unknown: 2}


  has_one :credential
  has_many :clients

  class << self

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

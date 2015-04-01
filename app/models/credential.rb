# app/models/credential.rb

class Credential < ActiveRecord::Base

  include Concerns::Credence

  has_secure_password
  has_secure_key_signature
  has_secure_multi_factor

  belongs_to :user

end

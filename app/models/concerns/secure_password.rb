# app/models/concerns/secure_password.rb

module Concerns

  module SecurePassword

    extend ActiveSupport::Concern

    # BCrypt hash function can handle maximum 72 characters, and if we pass
    # password of length more than 72 characters it ignores extra characters.
    # Hence need to put a restriction on password length.
    MAX_PASSWORD_LENGTH_ALLOWED = 72

    class << self
      attr_accessor :min_cost # :nodoc:
    end
    self.min_cost = false

    module ClassMethods
      # Adds methods to set and authenticate against a BCrypt password.
      # This mechanism requires you to have a +password_digest+ attribute
      # serialized as an EncryptedString.
      #
      # The following validations are added automatically:
      # * Password must be present on creation
      # * Password length should be less than or equal to 72 characters
      # * Confirmation of password (using a +password_confirmation+ attribute)
      #
      # If password confirmation validation is not needed, simply leave out the
      # value for +password_confirmation+ (i.e. don't provide a form field for
      # it). When this attribute has a +nil+ value, the validation will not be
      # triggered.
      #
      # For further customizability, it is possible to supress the default
      # validations by passing <tt>validations: false</tt> as an argument.
      #
      # Add bcrypt (~> 3.1.7) to Gemfile to use #has_secure_password:
      #
      #   gem 'bcrypt', '~> 3.1.7'
      #
      # Example using Active Record (which automatically includes ActiveModel::SecurePassword):
      #
      #   # Schema: Model(name:string, password_digest:string)
      #   class Model < ActiveRecord::Base
      #     has_secure_password
      #   end
      #
      #   model = Model.new(name: 'david', password: '', password_confirmation: 'nomatch')
      #   model.save                                                       # => false, password required
      #   model.password = 'mUc3m00RsqyRe'
      #   model.save                                                       # => false, confirmation doesn't match
      #   model.password_confirmation = 'mUc3m00RsqyRe'
      #   model.save                                                       # => true
      #   model.authenticate_by_password('notright')                                   # => false
      #   model.authenticate_by_password('mUc3m00RsqyRe')                              # => model
      #   Model.find_by(name: 'david').try(:authenticate_by_password, 'notright')      # => false
      #   Model.find_by(name: 'david').try(:authenticate_by_password, 'mUc3m00RsqyRe') # => model
      def has_secure_password(options = {})
        # Load bcrypt gem only when has_secure_password is used.
        # This is to avoid ActiveModel (and by extension the entire framework)
        # being dependent on a binary library.
        begin
          require 'bcrypt'
        rescue LoadError
          $stderr.puts "You don't have bcrypt installed in your application. Please add it to your Gemfile and run bundle install"
          raise
        end

        include InstanceMethodsOnActivation

        if options.fetch(:validations, true)
          include ActiveModel::Validations

          # This ensures the model has a password by checking whether the password_digest
          # is present, so that this works with both new and existing records. However,
          # when there is an error, the message is added to the password attribute instead
          # so that the error message will make sense to the end-user.
          validate do |record|
            record.errors.add(:password, :blank) unless record.password_digest.present?
          end

          validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
          validates_confirmation_of :password, allow_blank: true
        end

        # This code is necessary as long as the protected_attributes gem is supported.
        if respond_to?(:attributes_protected_by_default)
          def self.attributes_protected_by_default #:nodoc:
            super + ['password_digest']
          end
        end
      end
    end

    module InstanceMethodsOnActivation
      # Returns +self+ if the password is correct, otherwise +false+.
      #
      #   class Model < ActiveRecord::Base
      #     has_secure_password validations: false
      #   end
      #
      #   model = Model.new(name: 'david', password: 'mUc3m00RsqyRe')
      #   model.save
      #   model.authenticate_by_password('notright')      # => false
      #   model.authenticate_by_password('mUc3m00RsqyRe') # => model
      def authenticate_by_password(unencrypted_password)
        BCrypt::Password.new(password_digest) == unencrypted_password && self
      end

      attr_reader :password

      serialize :password_digest, ::EncryptedString

      # Encrypts the password into the +password_digest+ attribute, only if the
      # new password is not empty.
      #
      #   class Model < ActiveRecord::Base
      #     has_secure_password validations: false
      #   end
      #
      #   model = Model.new
      #   model.password = nil
      #   model.password_digest # => nil
      #   model.password = 'mUc3m00RsqyRe'
      #   model.password_digest # => "$2a$10$4LEA7r4YmNHtvlAvHhsYAeZmk/xeUVtMTYqwIvYY76EW5GUqDiP4."
      def password=(unencrypted_password)
        if unencrypted_password.nil?
          self.password_digest = nil
        elsif !unencrypted_password.empty?
          @password = unencrypted_password
          cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
          self.password_digest = BCrypt::Password.create(unencrypted_password, cost: cost)
        end
      end

      def password_confirmation=(unencrypted_password)
        @password_confirmation = unencrypted_password
      end
    end

  end # SecurePassword

end # Concerns
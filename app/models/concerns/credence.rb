require 'encrypted_string'
require 'encrypted_hash'

module Concerns

  module Credence

    extend ::ActiveSupport::Concern
    
    class << self
      attr_accessor :min_cost # :nodoc:
      attr_accessor :default_cost # :nodoc:
      attr_accessor :min_paswword_length # :nodoc:
      attr_accessor :max_paswword_length # :nodoc:

      attr_accessor :digest # :nodoc:
      attr_accessor :secret_key # :nodoc:
      attr_accessor :combine # :nodoc:

      # Digitally sign data using a secret (private key) along with an option set of values combined
      # using an HMAC digest
      #
      # @param [Object] secret  secret key
      # @param [Object] data  data to sign
      # @param [Array<Object>] optionals  optional values to include in signature digest
      # @return [String] base 64 encoded signature digest
      def sign(secret, data, *optionals)
        return nil unless ::Concerns::Credence.digest =~ /(sha512|sha384|sha256|sha1|sha|md5|mdc2|md4|ripemd160|dss1)/
        digest = OpenSSL::Digest.new(::Concerns::Credence.digest)
        secret = stringify(secret)
        data = stringify(data)
        if optionals
          optionals.each_with_index do |optional, index|
            optional = stringify(optional)
            optionals[index] = optional
          end
        end

        hmac = OpenSSL::HMAC.new(secret, digest)
        hmac.update(data)
        optionals.each_with_index do |optional, index|
          hmac.update(optional)
        end
        signed = hmac.digest
        Base64.strict_encode64(signed)
      end

      # Random nonce (generated once data)
      #
      # @param [Fixnum] size number of bytes of data
      # @return [String] base 64 encoded data
      def nonce(size=32)
        Base64.strict_encode64(OpenSSL::Random.random_bytes(size))
      end

      # Random base 32 secret which is RFC 4226 and RFC 6238 compliant
      #
      # @return [String] base 32 encoded secret
      def multi_factor_secret
        ROTP::Base32.random_base32
      end

      private

      # Convert object value to string
      #
      # @return [String] value
      def stringify(value)
        case value
          when Numeric
            value = value.to_s
          when Date, Time
            value = value.strftime("%Y-%m-%d %H:%M:%S")
          else
            value = value.to_s
        end
        value
      end

    end

    self.min_cost = false # Don't use minimum bcrypt cost
    self.default_cost = 11 # Default bcrypt cost
    self.min_paswword_length = 6 # Minimum password length
    self.max_paswword_length = 72 # Maximum password length

    self.digest = 'sha512' # Digital signing HMAC digest
    self.secret_key = ENV['CREDENCE_KEY'] || 'f3e7D5XyI0jc0NJuF+ScJJr8DBxf9D1EzZQ8yi06v+0L8G7zsswBWZcZhF/ULQyYzYTfMhfMIwlf7G38+Hq+uw=='
    self.combine = ['id', 'username'] # Default options for ditially signing

    module ClassMethods
      # Adds methods to set and authenticate against a BCrypt password.
      # This mechanism requires you to have a +password_digest+ attribute.
      #
      # Validations for presence of password on create, confirmation of password
      # (using a +password_confirmation+ attribute) are automatically added. If
      # you wish to turn off validations, pass <tt>validations: false</tt> as an
      # argument. You can add more validations by hand if need be.
      #
      # If you don't need the confirmation validation, just don't set any
      # value to the password_confirmation attribute and the validation
      # will not be triggered.
      #
      # You need to add bcrypt (~> 3.1.7) to Gemfile to use #has_secure_password:
      #
      #   gem 'bcrypt', '~> 3.1.7'
      #
      # Add secure password authentication
      # @param options
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

        attr_reader :password

        include SharedInstanceMethods
        include SecurePasswordInstanceMethods

        serialize :password_digest, ::EncryptedString

        if options.fetch(:validations, true)
          validate do |record|
            record.errors.add(:password, :blank) unless record.password_digest.present?
          end
          validates_length_of :password, minimum: ::Concerns::Credence.min_paswword_length, maximum: ::Concerns::Credence.max_paswword_length
          validates_confirmation_of :password, if: -> { password.present? }
        end

        if respond_to?(:attributes_protected_by_default)
          def self.attributes_protected_by_default #:nodoc:
            super + ['password_digest']
          end
        end

        define_singleton_method :minimum_password_length do
          ::Concerns::Credence.min_paswword_length
        end

        define_singleton_method :maximum_password_length do
          ::Concerns::Credence.max_paswword_length
        end

        define_singleton_method :suggested_password do |length=12, options={}|
          sans = options[:difficult] ? "".chars : "01IO`~^&*()_=+[]{}\|;:'\",.<>/?".chars
          ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ23456789`~!@#$%^&*()-_=+[]{}\|;:'\",.<>/?".chars-sans).sample(length).join
        end
      end


      # Add secure key/signature two legged authentication for API's
      # @param options
      def has_secure_key_signature(options = {})
        begin
          require 'cgi'
        rescue LoadError
          $stderr.puts "You don't have cgi installed in your application. Please add it to your Gemfile and run bundle install"
          raise
        end

        include SharedInstanceMethods
        include SecureKeySignatureInstanceMethods

        before_save :ensure_nonce

        serialize :signature_nonce, ::EncryptedString

        if respond_to?(:attributes_protected_by_default)
          def self.attributes_protected_by_default #:nodoc:
            super + ::Concerns::Credence.combine
          end
        end

        define_singleton_method :generate_secret do
          return {:secret => ::Concerns::Credence.nonce}
        end

      end

      # Add secure key/signature two legged authentication for API's
      # @param options
      def has_secure_multi_factor(options = {})
        begin
          require 'rotp'
        rescue LoadError
          $stderr.puts "You don't have rotp installed in your application. Please add it to your Gemfile and run bundle install"
          raise
        end

        include SharedInstanceMethods
        include SecureMultiFactorInstanceMethods

        before_save :ensure_multi_factor

        serialize :multi_factor_secret, ::EncryptedString
        serialize :multi_factor_backup_codes, ::EncryptedHash

        if respond_to?(:attributes_protected_by_default)
          def self.attributes_protected_by_default #:nodoc:
            super + ['multi_factor', 'multi_factor_secret', 'multi_factor_counter', 'multi_factor_phone', 'multi_factor_phone_number', 'multi_factor_phone_backup', 'multi_factor_phone_backup_number', 'multi_factor_authenticator', 'multi_factor_backup_codes']
          end
        end

        define_singleton_method :generate_multi_factor_secret do
          return {:multi_factor_secret => ::Concerns::Credence.multi_factor_secret}
        end
      end

    end

    module SharedInstanceMethods
      # Authenticate object
      #
      # @param [Hash] options
      # @option [String] password  unencrypted password
      # @option [String] key  object identifier
      # @option [Signature] signature  digitally signed HMAC digest
      # @option [String|Fixnum] timed_code  timed (TOTP) code
      # @option [String|Fixnum] backup_code  counter (HOTP) code
      # @option [Fixnum] drift  number of seconds tolerance between system clocks
      # @return [Object] self if authenticated, false if not
      def authenticate(options={})
        password = options[:password]
        key = options[:key]
        signature = options[:signature]
        timed_code = options[:timed_code]
        backup_code = options[:backup_code]
        drift = options[:drift]

        if password
          self.verify_password(password) && self
        elsif key && signature
          self.verify_key_signature(key, signature) && self
        elsif timed_code
          self.verify_timed_code(timed_code, drift: drift) && self
        elsif backup_code
          self.verify_backup_code(backup_code) && self.remove_backup_code(backup_code) && self
        else
          false
        end
      end
    end

    module SecurePasswordInstanceMethods
      # Encrypts the password into the password digest, only if the
      # new password is not blank.
      def password=(unencrypted_password)
        cost = ::Concerns::Credence.min_cost ? BCrypt::Engine::MIN_COST : ::Concerns::Credence.default_cost
        if unencrypted_password.nil?
          self.password_digest = nil
        elsif unencrypted_password.present?
          @password = unencrypted_password
          self.password_digest = BCrypt::Password.create(unencrypted_password, cost: cost).to_s
        end
      end

      # Set unencrypted password for confirmation
      def password_confirmation=(unencrypted_password)
        @password_confirmation = unencrypted_password
      end

      # Verify an unencrypted password against the encrypted password digest
      #
      # @return [Boolean] is verified
      def verify_password(unencrypted_password)
        #self.password_digest.present? && BCrypt::Password.new(self.password_digest) == unencrypted_password
        BCrypt::Password.new(self.password_digest) == unencrypted_password
      end

      # Authenticate object by password
      #
      # @param [String] password  unencrypted password
      # @return [Object] self if authenticated, false if not
      def authenticate_by_password(password)
        self.verify_password(password) && self
      end

    end

    module SecureKeySignatureInstanceMethods
      # Digitally sign self into encrypted signature
      def signature
        combined = [self.signature_nonce]
        ::Concerns::Credence.combine.each do |combine|
          combined << self.send("#{combine}") if self.send("#{combine}").present?
        end
        ::Concerns::Credence.sign(::Concerns::Credence.secret_key, self.id, *combined)
      end

      # Provide a set of digital signature details
      def keys
        {:key => self.id, :secret => ::Concerns::Credence.secret_key, :signature => self.signature, :secret_encoded => CGI.escape(::Concerns::Credence.secret_key), :signature_encoded => CGI.escape(self.signature)}
      end

      # Generate a new nonce
      def generate_nonce
        ::Concerns::Credence.nonce
      end

      # Verify a key/signature pair against the self encrypted signature
      #
      # @option [String] key  object identifier
      # @option [Signature] signature  digitally signed HMAC digest
      # @return [Boolean] is verified
      def verify_key_signature(key, signature)
        combined = [self.signature_nonce]
        ::Concerns::Credence.combine.each do |combine|
          combined << self.send("#{combine}") if self.send("#{combine}").present?
        end
        signature == ::Concerns::Credence.sign(::Concerns::Credence.secret_key, key, *combined)
      end

      # Authenticate object by key/signature
      #
      # @option [String] key  object identifier
      # @option [Signature] signature  digitally signed HMAC digest
      # @return [Object] self if authenticated, false if not
      def authenticate_by_key_signature(key, signature)
        self.verify_key_signature(key, signature) && self
      end

      # Ensure that nonce is never blank
      def ensure_nonce
        self.signature_nonce = self.generate_nonce if self.signature_nonce.blank?
      end
    end

    module SecureMultiFactorInstanceMethods
      # Generate a timed (TOTP) code
      #
      # @return [String] timed_code six digit timed code that expires in 30 seconds
      def generate_timed_code
        totp.now(true)
      end

      # Creates a new TOTP object using secret, issuer, and our interval.
      def totp
        @totp ||= ROTP::TOTP.new(self.multi_factor_secret, issuer: 'McNelis', interval: 5.minutes.to_i)
      end

      # Verify a timed (TOTP) code
      #
      # @option [String|Fixnum] timed_code  timed (TOTP) code
      # @param [Hash] options
      # @option [Fixnum] drift  number of seconds tolerance between system clocks
      # @return [Boolean] is verified
      def verify_timed_code(code, options={})
        drift = options[:drift] || 5.minutes.to_i
        code.gsub!(/[^0-9]/, '') if code.present?
        (code =~ /^\d{6}$/) && totp.verify_with_drift(code, drift)
      end

      # Authenticate object by timed (TOTP) code
      #
      # @option [String|Fixnum] timed_code  timed (TOTP) code
      # @param [Hash] options
      # @option [Fixnum] drift  number of seconds tolerance between system clocks
      # @return [Object] self if authenticated, false if not
      def authenticate_by_timed_code(code, options={})
        self.verify_timed_code(code, options) && self
      end

      # Generate an hmac counter (HOTP) backup code
      #
      # @param [Hash] options
      # @return [String] backup_code eight digit timed code that must match counter
      def generate_backup_code(counter, options={})
        code = hotp.at(counter, true)
      end

      # Creates a new HOTP object using secret, issuer, and our digits.
      def hotp
        @hotp ||= ROTP::HOTP.new(self.multi_factor_secret, digits: 8, issuer: 'McNelis')
      end

      # Generate hmac counter (HOTP) backup codes
      #
      # @param [Hash] codes backup codes to counter
      # @return [Hash] backup codes to counter
      def generate_backup_codes(codes=nil)
        codes = {} if codes.blank?
        need = 10 - codes.keys.length
        need.times do
          self.multi_factor_counter += 1
          codes[self.generate_backup_code(self.multi_factor_counter)] = self.multi_factor_counter
        end
        codes
      end

      # Remove an hmac counter (HOTP) code
      #
      # @param [String] code  backup code to verify
      # @return [Boolean] is removed
      def remove_backup_code(code)
        if self.multi_factor_backup_codes.include?(code)
          self.multi_factor_backup_codes.delete(code)
          self.multi_factor_counter += 1
          self.multi_factor_backup_codes[self.generate_backup_code(self.multi_factor_counter)] = self.multi_factor_counter
          self.save
          true
        else
          nil
        end
      end

      # Verify a timed (HOTP) code/counter pair
      #
      # @option [String|Fixnum] backup_code  counter (HOTP) code
      # @return [Boolean] is verified
      def verify_backup_code(code)
        return false if code.blank?
        code = code.gsub(/[^0-9]/, '')
        counter = self.multi_factor_backup_codes[code]
        counter.present? && code =~ /^\d{8}$/ && hotp.verify(code, counter)
      end

      # Authenticate object by timed (HOTP) code/counter pair
      #
      # @option [String|Fixnum] backup_code  counter (HOTP) code
      # @param [Hash] options
      # @option [Fixnum] drift  number of seconds tolerance between system clocks
      # @return [Object] self if authenticated, false if not
      def authenticate_by_backup_code(code)
        self.verify_backup_code(code) && self
      end

      # Authenticator application provisioning uri
      # otpauth://totp/McNelis:kwest@advisors.com?issuer=McNelis&secret=4n6fg5wxsh5buiwr
      #
      # @return [Boolean] uri
      def provisioning_uri
        totp.provisioning_uri("McNelis:#{self.username}")
      end


      # Authenticator application provisioning key
      # otpauth://totp/McNelis:kwest@advisors.com?issuer=McNelis&secret=4n6fg5wxsh5buiwr
      #
      # @return [Boolean] uri
      def provisioning_key
        self.multi_factor_secret.gsub(/.{4}(?=.)/, '\0 ')
      end


      # Send a timed (TOTP) code via SMS to a given phone
      #
      # @param [String] code  six digit timed code that expires in 30 seconds
      # @param [String] phone  SMS capable phone to receive code
      # @return [Boolean] sent
      def send_code_sms(code, phone)
        phone = phone.gsub(/[^0-9]/, '').gsub(/^1/, '')
        twilio = YAML.load_file(File.join(Rails.root, 'config', 'twilio.yml'))[Rails.env]
        from = "+1#{twilio['phone_number']}"
        to = "+1#{phone}"
        body = "Your McNelis verification code is: #{code}"
        twilio_client = Twilio::REST::Client.new(twilio['sid'], twilio['token'])
        sent = false
        begin
          twilio_client.account.sms.messages.create(from: from, to: to, body: body)
        rescue Twilio::REST::RequestError => e
          sent = false
        else
          sent = true
        end
        sent
      end

      # Enable multi factor authentication
      def enable_multi_factor
        self.ensure_multi_factor
        self.multi_factor = true
      end

      # Ensure multi factor authentication
      def ensure_multi_factor
        self.multi_factor_secret = ::Concerns::Credence.multi_factor_secret if self.multi_factor_secret.blank?
        if (self.multi_factor_backup_codes.blank? || self.multi_factor_backup_codes.keys.length < 10)
          self.multi_factor_backup_codes = self.generate_backup_codes(self.multi_factor_backup_codes)
        end
      end

      # Disables multi factor authentication for a user and clears all settings
      def disable_multi_factor
        attributes = {multi_factor: false, multi_factor_phone: false, multi_factor_phone_number: nil, multi_factor_phone_backup: false, multi_factor_phone_backup_number: false, multi_factor_authenticator: false}
        self.update_attributes!(attributes)
      end
    end

  end # Credence

end # Concerns

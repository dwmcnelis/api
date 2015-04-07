# lib/encrypted_string.rb

class EncryptedString < String

  class << self
    # Dump(serialize) string
    #
    # @param [String|EncryptedString] string         String
    # @return [String] serialized    Serialized encrypted string
    # :nocov:
    def dump(string)
      string && !string.nil? && (string.class == String || string.class == EncryptedString) ? string.encrypt(:symmetric, password: Rails.application.secrets.secret_key_base).to_s : nil
    end
    # :nocov:


    # Load(unserialize) serialized encrypted string
    #
    # @param [String] serialized        Serialized encrypted string
    # @return [String] unserialized     String
    # :nocov:
    def load(serialized)
      begin
        serialized && serialized.class == String ? serialized.decrypt(:symmetric, :password => Rails.application.secrets.secret_key_base) : nil
      rescue
        nil
      end
    end
    # :nocov:
  end # class << self

end # EncryptedString
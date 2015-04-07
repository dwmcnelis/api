# lib/encrypted_hash.rb

class EncryptedHash < Hash

  class << self
    # Dump(serialize) hash
    #
    # @param [Hash|EncryptedHash] hash             Hash
    # @return [String] serialized    Serialized encrypted hash
    # :nocov:
    def dump(hash)
      hash && !hash.nil? && (hash.class == Hash || hash.class == EncryptedHash) ? Marshal.dump(hash).encrypt(:symmetric, password: Rails.application.secrets.secret_key_base).to_s : nil
    end
    # :nocov:


    # Load(unserialize) serialized encrypted hash
    #
    # @param [String] serialized    Serialized encrypted hash
    # @return [Hash] object         Hash
    # :nocov:
    def load(serialized)
      serialized && serialized.class == String ? Marshal.load(serialized.decrypt(:symmetric, :password => Rails.application.secrets.secret_key_base)) : nil
    end
    # :nocov:
  end # class << self

end

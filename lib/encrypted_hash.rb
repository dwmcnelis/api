class EncryptedHash < Hash

  class << self
    # Dump(serialize) hash
    #
    # @param [Hash|EncryptedHash] hash             Hash
    # @return [String] serialized    Serialized encrypted hash
    def dump(hash)
      hash && !hash.nil? && (hash.class == Hash || hash.class == EncryptedHash) ? Marshal.dump(hash).encrypt(:symmetric, password: Rails.application.secrets.secret_key_base).to_s : nil
    end


    # Load(unserialize) serialized encrypted hash
    #
    # @param [String] serialized    Serialized encrypted hash
    # @return [Hash] object         Hash
    def load(serialized)
      serialized && serialized.class == String ? Marshal.load(serialized.decrypt(:symmetric, :password => Rails.application.secrets.secret_key_base)) : nil
    end
  end # class << self

end

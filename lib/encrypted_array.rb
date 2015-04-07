# lib/encrypted_array.rb

class EncryptedArray < Array

  class << self
    # Dump(serialize) array
    #
    # @param [Array|EncryptedArray] array             Array
    # @return [String] serialized    Serialized encrypted array
    # :nocov:
    def dump(array)
      array && !array.nil? && (array.class == Array || array.class == EncryptedArray) ? Marshal.dump(array).encrypt(:symmetric, password: Rails.application.secrets.secret_key_base).to_s : nil
    end
    # :nocov:


    # Load(unserialize) serialized encrypted array
    #
    # @param [String] serialized    Serialized encrypted array
    # @return [Array] object         Array
    # :nocov:
    def load(serialized)
      serialized && serialized.class == String ? Marshal.load(serialized.decrypt(:symmetric, :password => Rails.application.secrets.secret_key_base)) : nil
    end
    # :nocov:
  end # class << self

end

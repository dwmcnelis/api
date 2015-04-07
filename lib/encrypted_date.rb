# lib/encrypted_date.rb

class EncryptedDate < Date

  class << self
    # Dump(serialize) date
    #
    # @param [Date|EncryptedDate] date                 Date
    # @return [String] serialized        Serialized encrypted date
    # :nocov:
    def dump(date)
      date && !hash.nil? && (date.class == Date || date.class == EncryptedDate) ? date.to_s.encrypt(:symmetric, password: Rails.application.secrets.secret_key_base).to_s : nil
    end
    # :nocov:


    # Load(unserialize) serialized encrypted date
    #
    # @param [String] serialized        Serialized encrypted date
    # @return [Date] unserialized       Date
    # :nocov:
    def load(serialized)
      if serialized && serialized.class == String
        begin
          Date.parse(serialized.decrypt(:symmetric, :password => Rails.application.secrets.secret_key_base))
        rescue
          nil
        end
      else
        nil
      end
    end
    # :nocov:
  end # class << self

end

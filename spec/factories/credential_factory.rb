# spec/factories/credential_factory.rb

FactoryGirl.define do

  factory :credential, class: 'Credential' do

# "user_id", "password_digest", "signature_nonce", 
# "multi_factor", "multi_factor_secret", "multi_factor_counter", "multi_factor_phone", 
# "multi_factor_phone_number", "multi_factor_phone_backup", "multi_factor_phone_backup_number", 
# "multi_factor_authenticator", "multi_factor_backup_codes"

    password { 'secret' }

    trait :multi_factor do
      multi_factor { true }
    end

  end

end

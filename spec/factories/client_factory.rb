# spec/factories/client_factory.rb

FactoryGirl.define do

  factory :client, class: 'Client' do

    first_name  { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email  { Faker::Internet.email }
    phone  { Faker::PhoneNumber.phone_number }
    level  { Client.level_enum.keys.map(&:to_s).sample }
    status  { Client.status_enum.keys.map(&:to_s).sample }
    notes  { Faker::Lorem.paragraph(2) }

  end

end

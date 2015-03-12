
FactoryGirl.define do

  factory :client, class: 'Client' do

    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    phone Faker::PhoneNumber.phone_number
    status ['new', 'in progress', 'closed', 'bad'].sample
    notes Faker::Lorem.paragraph(2)

  end

end

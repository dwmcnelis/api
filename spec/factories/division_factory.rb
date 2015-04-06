# spec/factories/division_factory.rb

FactoryGirl.define do

  factory :division, class: 'Division' do

    short_name { Faker::Name.first_name }
    full_name { Faker::Name.last_name }

  end

end

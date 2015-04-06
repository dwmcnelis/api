# spec/factories/team_factory.rb

FactoryGirl.define do

  factory :conference, class: 'Conference' do

    short_name { Faker::Name.first_name }
    full_name { Faker::Name.last_name }

  end

end

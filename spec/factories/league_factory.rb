# spec/factories/league_factory.rb

FactoryGirl.define do

  factory :league, class: 'League' do

    short_name { Faker::Name.first_name }
    full_name { Faker::Name.last_name }

  end

end

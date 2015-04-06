# spec/factories/team_factory.rb

FactoryGirl.define do

  factory :team, class: 'Team' do

    sequence(:name) {|n| "#{Faker::Name.first_name}#{n}" }
    level { Team.level_enum.keys.map(&:to_s).sample }
    kind { Team.kind_enum.keys.map(&:to_s).sample }

  end

end

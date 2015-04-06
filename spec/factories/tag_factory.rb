# spec/factories/tag_factory.rb

FactoryGirl.define do

  factory :tag, class: 'Tag' do

    as { Tag.as_enum.keys.map(&:to_s).sample }
    name { Faker::Name.first_name }

  end

end

# spec/models/tag_spec.rb

require 'rails_helper'

describe Tag do
  subject { described_class }

  it "has a valid factory" do
    expect(FactoryGirl.create(:tag)).to be_valid
  end

  it 'creates tag given valid attributes' do
    attributes = {
      as: Tag.as_enum.keys.map(&:to_s).sample,
      name: Faker::Name.first_name
    }
    expect(Tag.create!(attributes)).to be_valid
  end

end # Tag

# spec/models/conference_spec.rb

require 'rails_helper'

describe Conference do
  subject { described_class }

  it "has a valid factory" do
    expect(FactoryGirl.create(:conference)).to be_valid
  end

  it 'creates conference given valid attributes' do
    attributes = {
      short_name: Faker::Name.first_name,
      full_name: Faker::Name.last_name,
    }
    expect(Conference.create!(attributes)).to be_valid
  end

end # Conference
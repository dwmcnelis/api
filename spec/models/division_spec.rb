# spec/models/division_spec.rb

require 'rails_helper'

describe Division do
  subject { described_class }

  it "has a valid factory" do
    expect(FactoryGirl.create(:division)).to be_valid
  end

  it 'creates division given valid attributes' do
    attributes = {
      short_name: Faker::Name.first_name,
      full_name: Faker::Name.last_name,
    }
    expect(Division.create!(attributes)).to be_valid
  end

end # Division
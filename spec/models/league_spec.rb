# spec/models/league_spec.rb

require 'rails_helper'

describe League do
  subject { described_class }

  it "has a valid factory" do
    expect(FactoryGirl.create(:league)).to be_valid
  end

  it 'creates league given valid attributes' do
    attributes = {
      short_name: Faker::Name.first_name,
      full_name: Faker::Name.last_name,
    }
    expect(League.create!(attributes)).to be_valid
  end

end # League
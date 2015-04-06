# spec/models/client_spec.rb

require 'rails_helper'

describe Client do
  subject { described_class }

  it "has a valid factory" do
    expect(FactoryGirl.create(:client)).to be_valid
  end

  it 'creates client given valid attributes' do
    attributes = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      status: Client.status_enum.keys.map(&:to_s).sample,
      level: Client.level_enum.keys.map(&:to_s).sample,
      notes: Faker::Lorem.paragraph(2)
    }
    expect(Client.create!(attributes)).to be_valid
  end

end # Client
# spec/models/client_spec.rb

require 'rails_helper'

describe Client do
  subject { described_class }

  let!(:user) { create(:user) }
  let!(:client1) { create(:client, user_id: user.id) }
  let!(:client2) { create(:client, user_id: user.id) }
  let!(:client3) { create(:client, user_id: user.id) }
  let!(:unowned_client) { create(:client) }
  let!(:other_user) { create(:user) }

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

  it 'can be searched by first name' do
    query = client2.first_name.first(2)
    result = Client.search(query).all
    expect(result).not_to be_nil
    ids = result.map(&:id)
    expect(ids.include?(client2.id)).to eq(true)
  end

  it 'can be searched by last name' do
    query = client2.last_name.first(2)
    result = Client.search(query).all
    expect(result).not_to be_nil
    ids = result.map(&:id)
    expect(ids.include?(client2.id)).to eq(true)
  end

  it 'is owner' do
    expect(client1.owner?(user)).to eq(true)
  end

  it 'is not owner' do
    expect(client1.owner?(other_user)).not_to eq(true)
  end

  it 'is unowned' do
    expect(unowned_client.unowned?).to eq(true)
  end

  it 'is not unowned' do
    expect(client1.unowned?).not_to eq(true)
  end

  it 'has corrent full name' do
    expect(client1.full_name).to eq(client1.first_name+' '+client1.last_name)
  end

  it 'has corrent sort name' do
    expect(client1.sort_name).to eq(client1.last_name+', '+client1.first_name)
  end

end # Client
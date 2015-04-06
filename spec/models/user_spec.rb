# spec/models/user_spec.rb

require 'rails_helper'

describe User do
  subject { described_class }

  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:admin_user) { create(:user, :admin_user) }
  let!(:alpha_user) { create(:user, :alpha_user) }
  let!(:beta_user) { create(:user, :beta_user) }
  let!(:banned_user) { create(:user, :banned_user) }
  let!(:tos_accepted_user) { create(:user, :tos_accepted) }

  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  # it "is invalid without a username" do
  #   Factory.build(:user, username: nil).should_not be_valid
  # end

  it 'creates client given valid attributes' do
    attributes = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: Faker::Internet.email
    }
    expect(User.create!(attributes)).to be_valid
  end

  it 'can be searched by first name' do
    query = user2.first_name.first(2)
    result = User.search(query).all
    expect(result).not_to be_nil
    ids = result.map(&:id)
    expect(ids.include?(user2.id)).to eq(true)
  end

  it 'can be searched by last name' do
    query = user2.last_name.first(2)
    result = User.search(query).all
    expect(result).not_to be_nil
    ids = result.map(&:id)
    expect(ids.include?(user2.id)).to eq(true)
  end

  it 'can be searched by username' do
    query = user2.username.first(2)
    result = User.search(query).all
    expect(result).not_to be_nil
    ids = result.map(&:id)
    expect(ids.include?(user2.id)).to eq(true)
  end

  it 'can be found by username/password' do
    result = User.find_by_username_password(user1.username, 'secret')
    expect(result).not_to be_nil
    expect(result.id).to eq(user1.id)
  end

  it 'can be found by token' do
    token = user2.generate_token.to_s
    result = User.find_by_token(token)
    expect(result).not_to be_nil
    expect(result.id).to eq(user2.id)
  end

  it 'can be valid' do
    expect(user1.is_valid?).to eq(true)
  end

  it 'generates a valid token' do
    token = user2.generate_token
    expect(token.valid?).to eq(true)
  end

  it 'can be admin user' do
    expect(admin_user.admin?).to eq(true)
  end

  it 'can be alpha user' do
    expect(alpha_user.alpha?).to eq(true)
  end

  it 'can be beta user' do
    expect(beta_user.beta?).to eq(true)
  end

  it 'can be banned user' do
    expect(banned_user.banned?).to eq(true)
  end

  it 'can be tos accepted user' do
    expect(tos_accepted_user.tos?).to eq(true)
  end
end # User
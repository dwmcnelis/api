# spec/models/tag_spec.rb

require 'rails_helper'

describe Tag do
  subject { described_class }

  let!(:tag1) { create(:tag) }
  let!(:tag2) { create(:tag, description: 'Something') }
  let!(:tag3) { create(:tag) }

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

  it 'can be found or created' do
    expect(Tag.find_or_create(tag1.as, tag1.name)).to eq(tag1)
  end

  it 'can be searched by name' do
    query = tag2.name.first(2)
    result = Tag.search(query).all
    expect(result).not_to be_nil
    ids = result.map(&:id)
    expect(ids.include?(tag2.id)).to eq(true)
  end

  it 'can be searched by description' do
    query = tag2.description.first(2)
    result = Tag.search(query).all
    expect(result).not_to be_nil
    ids = result.map(&:id)
    expect(ids.include?(tag2.id)).to eq(true)
  end


end # Tag

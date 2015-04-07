# spec/models/tagging_spec.rb

require 'rails_helper'

describe Tagging do
  subject { described_class }

  let!(:team) { create(:team) }
  let!(:tag) { create(:tag) }
  let!(:other_tag) { create(:tag) }
  let!(:tagging) { create(:tagging, as: 'sports', tag_id: other_tag.id, tagged_type: team.class.name, tagged_id: team.id) }


  it "has a valid factory" do
    attributes = {
      as: Tagging.as_enum.keys.map(&:to_s).sample,
      tagged_type: team.class.name,
      tagged_id: team.id,
      tag_id: tag.id,
    }
    expect(FactoryGirl.create(:tagging, attributes)).to be_valid
  end

  it 'creates tagging given valid attributes' do
    attributes = {
      as: Tagging.as_enum.keys.map(&:to_s).sample,
      tagged_type: team.class.name,
      tagged_id: team.id,
      tag_id: tag.id,
    }
    expect(Tagging.create!(attributes)).to be_valid
  end

end # Tagging

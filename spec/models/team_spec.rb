# spec/models/team_spec.rb

require 'rails_helper'

describe Team do
  subject { described_class }

  it "has a valid factory" do
    expect(FactoryGirl.create(:team)).to be_valid
  end

  it 'creates team given valid attributes' do
    attributes = {
      name: Faker::Name.first_name,
      level: Team.level_enum.keys.map(&:to_s).sample,
      kind: Team.kind_enum.keys.map(&:to_s).sample
    }
    expect(Team.create!(attributes)).to be_valid
  end

end # Team

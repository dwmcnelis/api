# spec/models/team_spec.rb

require 'rails_helper'

describe Team do
  subject { described_class }

  let!(:team1) { create(:team) }
  let!(:team2) { create(:team, aliases: 'one two three') }
  let!(:team3) { create(:team) }

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

  it 'can be found or created' do
    expect(Team.find_or_create(team1.name, team1.level, team1.kind)).to eq(team1)
  end

  it 'can be searched by name' do
    query = team2.name.first(2)
    result = Team.search(query).all
    expect(result).not_to be_nil
    ids = result.map(&:id)
    expect(ids.include?(team2.id)).to eq(true)
  end

  it 'can be searched by aliases' do
    query = team2.aliases.first(2)
    result = Team.search(query).all
    expect(result).not_to be_nil
    ids = result.map(&:id)
    expect(ids.include?(team2.id)).to eq(true)
  end


end # Team

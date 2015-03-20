
namespace :db do
  namespace :populate do
    task :'ncaa-football-teams' => :environment do

      ncaa = League.create(short_name: 'NCAA', full_name: 'National College Atheltic Associtation', user_id: nil, verified: 1)
      ncaa_football_division_i_a = Division.create(short_name: 'Division I-A', full_name: 'FBS (Division I-A)', user_id: nil, verified: 1)
      ncaa_football_american_athletic = Conference.create(short_name: 'American Athletic', full_name: 'American Athletic Conference', user_id: nil, verified: 1)

      # American Athletic
			Team.create(name: 'Cincinnati Bearcats', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'Connecticut Huskies', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'East Carolina Pirates', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'Houston Cougars', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'Memphis Tigers', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'SMU Mustangs', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'South Florida Bulls', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'Temple Owls', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'Tulane Green Wave', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'Tulsa Hurricane', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			Team.create(name: 'UCF Knights', level: :college, kind: :football, league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
		
    end
  end
end

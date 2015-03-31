
namespace :db do
  namespace :populate do
    task :'ncaa-football-teams' => :environment do

      ncaa = League.create(short_name: 'NCAA', full_name: 'National College Atheltic Associtation', user_id: nil, verified: 1)
      ncaa_football_division_i_a = Division.create(short_name: 'Division I-A', full_name: 'FBS (Division I-A)', user_id: nil, verified: 1)
      ncaa_football_american_athletic = Conference.create(short_name: 'American Athletic', full_name: 'American Athletic Conference', user_id: nil, verified: 1)

      # American Athletic
			team = Team.find_or_create('Cincinnati Bearcats', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			team = Team.find_or_create('Connecticut Huskies', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1, aliases: "uconn")
			team = Team.find_or_create('East Carolina Pirates', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			team = Team.find_or_create('Houston Cougars', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			team = Team.find_or_create('Memphis Tigers', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			team = Team.find_or_create('SMU Mustangs', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			team = Team.find_or_create('South Florida Bulls', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			team = Team.find_or_create('Temple Owls', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			team = Team.find_or_create('Tulane Green Wave', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			team = Team.find_or_create('Tulsa Hurricane', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)
			team = Team.find_or_create('UCF Knights', :college, :football)
			team.update_attributes(league_id: ncaa.id, division_id: ncaa_football_division_i_a.id, conference_id: ncaa_football_american_athletic.id, user_id: nil, verified: 1)

    end
  end
end

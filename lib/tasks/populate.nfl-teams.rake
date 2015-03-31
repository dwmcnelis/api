
namespace :db do
  namespace :populate do
    task :'nfl-teams' => :environment do

      nfl = League.create(short_name: 'NFL', full_name: 'National Football League', user_id: nil, verified: 1)
      nfc = Division.create(short_name: 'NFC', full_name: 'National Football Conference', user_id: nil, verified: 1)
      nfc_east = Conference.create(short_name: 'NFC East', full_name: 'National Football Conference - East', user_id: nil, verified: 1)
      nfc_west = Conference.create(short_name: 'NFC West', full_name: 'National Football Conference - West', user_id: nil, verified: 1)
      nfc_north = Conference.create(short_name: 'NFC North', full_name: 'National Football Conference - North', user_id: nil, verified: 1)
      nfc_south = Conference.create(short_name: 'NFC South', full_name: 'National Football Conference - South', user_id: nil, verified: 1)
      afc = Division.create(short_name: 'AFC', full_name: 'American Football Conference', user_id: nil, verified: 1)
      afc_east = Conference.create(short_name: 'AFC East', full_name: 'American Football Conference - East', user_id: nil, verified: 1)
      afc_west = Conference.create(short_name: 'AFC West', full_name: 'American Football Conference - West', user_id: nil, verified: 1)
      afc_north = Conference.create(short_name: 'AFC North', full_name: 'American Football Conference - North', user_id: nil, verified: 1)
      afc_south = Conference.create(short_name: 'AFC South', full_name: 'American Football Conference - South', user_id: nil, verified: 1)

      # AFC East
			team = Team.find_or_create('Buffalo Bills', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_east.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Miami Dolphins', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_east.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('New England Patriots', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_east.id, user_id: nil, verified: 1, aliases: "ne pats")
			team = Team.find_or_create('New York Jets', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_east.id, user_id: nil, verified: 1, aliases: "ny")

		
			# AFC West
			team = Team.find_or_create('Denver Broncos', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_west.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Kansas City Chiefs', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_west.id, user_id: nil, verified: 1, aliases: "kc")
			team = Team.find_or_create('Oakland Raiders', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_west.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('San Diego Chargers', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_west.id, user_id: nil, verified: 1, aliases: "sd")

			# AFC North
			team = Team.find_or_create('Baltimore Ravens', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_north.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Cincinnati Bengals', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_north.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Cleveland Browns', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_north.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Pittsburgh Steelers', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_north.id, user_id: nil, verified: 1, aliases: nil)

			# AFC South
			team = Team.find_or_create('Houston Texans', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_south.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Indianapolis Colts', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_south.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Jacksonville Jaguars', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_south.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Tennessee Titans', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: afc.id, conference_id: afc_south.id, user_id: nil, verified: 1, aliases: nil)

      # NFC East
			team = Team.find_or_create('Dallas Cowboys', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_east.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('New York Giants', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_east.id, user_id: nil, verified: 1, aliases: "ny")
			team = Team.find_or_create('Philadelphia Eagles', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_east.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Washington Redskins', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_east.id, user_id: nil, verified: 1, aliases: nil)
	
      # NFC West
			team = Team.find_or_create('Arizona Cardinals', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_west.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('San Francisco 49ers', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_west.id, user_id: nil, verified: 1, aliases: "sf")
			team = Team.find_or_create('Seattle Seahawks', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_west.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('St. Louis Rams', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_west.id, user_id: nil, verified: 1, aliases: "sl")

      # NFC North
			team = Team.find_or_create('Chicago Bears', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_north.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Detroit Lions', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_north.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Green Bay Packers', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_north.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Minnesota Vikings', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_north.id, user_id: nil, verified: 1, aliases: "purple")


      # NFC South
			team = Team.find_or_create('Atlanta Falcons', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_south.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('Carolina Panthers', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_south.id, user_id: nil, verified: 1, aliases: nil)
			team = Team.find_or_create('New Orleans Saints', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_south.id, user_id: nil, verified: 1, aliases: "no")
			team = Team.find_or_create('Tampa Bay Buccaneers', :professional, :football)
			team.update_attributes(league_id: nfl.id, division_id: nfc.id, conference_id: nfc_south.id, user_id: nil, verified: 1, aliases: "tb")

    end
  end
end

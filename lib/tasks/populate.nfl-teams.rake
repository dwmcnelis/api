
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
			Team.create(name: 'Buffalo Bills', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_east.id, user_id: nil, verified: 1)
			Team.create(name: 'Miami Dolphins', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_east.id, user_id: nil, verified: 1)
			Team.create(name: 'New England Patriots', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_east.id, user_id: nil, verified: 1)
			Team.create(name: 'New York Jets', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_east.id, user_id: nil, verified: 1)
		
			# AFC West
			Team.create(name: 'Denver Broncos', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_west.id, user_id: nil, verified: 1)
			Team.create(name: 'Kansas City Chiefs', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_west.id, user_id: nil, verified: 1)
			Team.create(name: 'Oakland Raiders', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_west.id, user_id: nil, verified: 1)
			Team.create(name: 'San Diego Chargers', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_west.id, user_id: nil, verified: 1)

			# AFC North
			Team.create(name: 'Baltimore Ravens', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_north.id, user_id: nil, verified: 1)
			Team.create(name: 'Cincinnati Bengals', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_north.id, user_id: nil, verified: 1)
			Team.create(name: 'Cleveland Browns', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_north.id, user_id: nil, verified: 1)
			Team.create(name: 'Pittsburgh Steelers', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_north.id, user_id: nil, verified: 1)

			# AFC South
			Team.create(name: 'Houston Texans', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_south.id, user_id: nil, verified: 1)
			Team.create(name: 'Indianapolis Colts', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_south.id, user_id: nil, verified: 1)
			Team.create(name: 'Jacksonville Jaguars', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_south.id, user_id: nil, verified: 1)
			Team.create(name: 'Tennessee Titans', level: :professional, kind: :football, league_id: nfl.id, division_id: afc.id, conference_id: afc_south.id, user_id: nil, verified: 1)


      # NFC East
			Team.create(name: 'Dallas Cowboys', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_east.id, user_id: nil, verified: 1)
			Team.create(name: 'New York Giants', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_east.id, user_id: nil, verified: 1)
			Team.create(name: 'Philadelphia Eagles', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_east.id, user_id: nil, verified: 1)
			Team.create(name: 'Washington Redskins', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_east.id, user_id: nil, verified: 1)
	
      # NFC West
			Team.create(name: 'Arizona Cardinals', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_west.id, user_id: nil, verified: 1)
			Team.create(name: 'San Francisco 49ers', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_west.id, user_id: nil, verified: 1)
			Team.create(name: 'Seattle Seahawks', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_west.id, user_id: nil, verified: 1)
			Team.create(name: 'St. Louis Rams', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_west.id, user_id: nil, verified: 1)

      # NFC North
			Team.create(name: 'Chicago Bears', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_north.id, user_id: nil, verified: 1)
			Team.create(name: 'Detroit Lions', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_north.id, user_id: nil, verified: 1)
			Team.create(name: 'Green Bay Packers', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_north.id, user_id: nil, verified: 1)
			Team.create(name: 'Minnesota Vikings', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_north.id, user_id: nil, verified: 1)

      # NFC South
			Team.create(name: 'Atlanta Falcons', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_south.id, user_id: nil, verified: 1)
			Team.create(name: 'Carolina Panthers', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_south.id, user_id: nil, verified: 1)
			Team.create(name: 'New Orleans Saints', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_south.id, user_id: nil, verified: 1)
			Team.create(name: 'Tampa Bay Buccaneers', level: :professional, kind: :football, league_id: nfl.id, division_id: nfc.id, conference_id: nfc_south.id, user_id: nil, verified: 1)

    end
  end
end

#American Football Conference (AFC)

# #East
# 'Buffalo Bills'
# 'Miami Dolphins'
# 'New England Patriots'
# 'New York Jets'

# #North
# 'Baltimore Ravens'
# 'Cincinnati Bengals'
# 'Cleveland Browns'
# 'Pittsburgh Steelers'

# #South
# 'Houston Texans'
# 'Indianapolis Colts'
# 'Jacksonville Jaguars'
# 'Tennessee Titans'

# #West
# 'Denver Broncos'
# 'Kansas City Chiefs'
# 'Oakland Raiders'
# 'San Diego Chargers'

# #National Football Conference (NFC)

# #East
# 'Dallas Cowboys'
# 'New York Giants'
# 'Philadelphia Eagles'
# 'Washington Redskins'

# #North
# 'Chicago Bears'
# 'Detroit Lions'
# 'Green Bay Packers'
# 'Minnesota Vikings'

# #South
# 'Atlanta Falcons'
# 'Carolina Panthers'
# 'New Orleans Saints'
# 'Tampa Bay Buccaneers'

# #West
# 'Arizona Cardinals'
# 'St. Louis Rams'
# 'San Francisco 49ers'
# 'Seattle Seahawks'

namespace :db do
  namespace :populate do
    task :teams => :environment do

	    def nfl_team_names
	    	[
					'Buffalo Bills',
					'Miami Dolphins',
					'New England Patriots',
					'New York Jets',
					'Baltimore Ravens',
					'Cincinnati Bengals',
					'Cleveland Browns',
					'Pittsburgh Steelers',
					'Houston Texans',
					'Indianapolis Colts',
					'Jacksonville Jaguars',
					'Tennessee Titans',
					'Denver Broncos',
					'Kansas City Chiefs',
					'Oakland Raiders',
					'San Diego Chargers',
					'Dallas Cowboys',
					'New York Giants',
					'Philadelphia Eagles',
					'Washington Redskins',
					'Chicago Bears',
					'Detroit Lions',
					'Green Bay Packers',
					'Minnesota Vikings',
					'Atlanta Falcons',
					'Carolina Panthers',
					'New Orleans Saints',
					'Tampa Bay Buccaneers',
					'Arizona Cardinals',
					'St. Louis Rams',
					'San Francisco 49ers',
					'Seattle Seahawks'
				]
	    end

      user = User.find_by_username('davemcnelis@gmail.com')

      nfl_team_names.each do |name| 
        Team.create(
          name: name,
          slug: Team.slugify(name),
          level: :professional,
          kind: :football,
          user_id: user.id,
        )
      end

    end
  end
end

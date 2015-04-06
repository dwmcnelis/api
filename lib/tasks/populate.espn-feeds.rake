
namespace :db do
  namespace :populate do
    task :'espn-feeds' => :environment do

    	def feeds
    		[
    			{title: 'ESPN NFL', url: 'http://sports.espn.go.com/espn/rss/nfl/news'},
    			{title: 'ESPN NBA', url: 'http://sports.espn.go.com/espn/rss/nba/news'},
    			{title: 'ESPN MLB', url: 'http://sports.espn.go.com/espn/rss/mlb/news'},
    			{title: 'ESPN NHL', url: 'http://sports.espn.go.com/espn/rss/nhl/news'},
    			{title: 'ESPN Golf', url: 'http://sports.espn.go.com/espn/rss/golf/news'},
    			# {title: 'ESPN Soccer', url: 'http://www.espnfc.com/rss'},
    			{title: 'ESPN College Basketball', url: 'http://sports.espn.go.com/espn/rss/ncb/news'},
    			{title: 'ESPN College Football', url: 'http://sports.espn.go.com/espn/rss/ncf/news'},
    		]
    	end

    	feeds.each do |feed|
    		feed = Feed.find_or_create('sports',feed[:title],feed[:url])
    		feed.aggregate!
    	end

    end
  end
end
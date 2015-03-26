
namespace :db do
  namespace :populate do
    task :'team-tags' => :environment do

    	Team.all.each do |team| 
    		Tag.find_or_create('sports', team.name, team.grouping)
    	end

    end
  end
end

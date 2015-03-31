
namespace :db do
  namespace :populate do
    task :'team-tags' => :environment do

    	Team.all.each do |team| 
		  	tag = Tag.find_or_create('sports', team.name, team.kind)
        tag.update_attributes(for_type: 'Team', for_id: team.id, grouping: team.grouping, aliases: team.aliases, verified: true)
    	end

    end
  end
end

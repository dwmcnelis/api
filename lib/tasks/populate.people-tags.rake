
namespace :db do
  namespace :populate do
    task :'people-tags' => :environment do

        Client.all.each do |client| 
            tag = Tag.find_or_create('people', client.sort_name, nil, client.user_id)
            tag.update_attributes(for_type: 'Client', for_id: client.id, grouping: 'client', verified: true)
        end

    end
  end
end

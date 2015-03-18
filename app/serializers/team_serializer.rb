class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :level, :type, :league_id, :division_id, :founded, :location, :arena
end

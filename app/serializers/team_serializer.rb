# app/serializers/team_serializer.rb

class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :level, :kind, :league_id, :division_id, :founded, :location, :arena
end

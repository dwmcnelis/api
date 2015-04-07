# app/models/league.rb

# Team league
#

class League < ActiveRecord::Base

  has_one :user
  has_many :teams
  
end

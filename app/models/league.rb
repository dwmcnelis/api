class League < ActiveRecord::Base

  has_one :user
  has_many :teams
  
end

# app/models/division.rb

# Team division
#

class Division < ActiveRecord::Base

  has_one :user
  has_many :teams
  
end

# app/models/conference.rb

# Team conference
#

class Conference < ActiveRecord::Base

  has_one :user
  has_many :teams
  
end

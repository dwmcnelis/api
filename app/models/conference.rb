# app/models/conference.rb

class Conference < ActiveRecord::Base

  has_one :user
  has_many :teams
  
end

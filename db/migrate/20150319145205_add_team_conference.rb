class AddTeamConference < ActiveRecord::Migration
  def change
  	add_column :teams, :conference_id, :uuid, after: :division_id
  end
end

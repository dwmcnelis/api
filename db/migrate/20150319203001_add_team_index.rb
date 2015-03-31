class AddTeamIndex < ActiveRecord::Migration
  def change
    add_index :teams, [:name, :level, :kind], unique: true, name: 'teams_index'
  end
end

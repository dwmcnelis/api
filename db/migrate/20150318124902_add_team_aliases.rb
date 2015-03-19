class AddTeamAliases < ActiveRecord::Migration
  def change
  	add_column :teams, :aliases, :string, after: :name
  end
end

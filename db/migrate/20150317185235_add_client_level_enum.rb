class AddClientLevelEnum < ActiveRecord::Migration
  def change
  	rename_column :clients, :level, :old_level
  	add_column :clients, :level, :integer, before: :old_level, default: 1
	end
end

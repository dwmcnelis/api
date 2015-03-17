class DropOldClientLevel < ActiveRecord::Migration
  def change
  	remove_column :clients, :old_level
  end
end

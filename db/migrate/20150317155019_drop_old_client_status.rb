class DropOldClientStatus < ActiveRecord::Migration
  def change
  	remove_column :clients, :old_status
  end
end

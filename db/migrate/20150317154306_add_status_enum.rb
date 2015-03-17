class AddStatusEnum < ActiveRecord::Migration
  def change
  	rename_column :clients, :status, :old_status
  	add_column :clients, :status, :integer, before: :old_status
  end
end

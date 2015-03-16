class AddClientLevel < ActiveRecord::Migration
  def change
  	add_column :clients, :level, :integer, before: :status
  end
end

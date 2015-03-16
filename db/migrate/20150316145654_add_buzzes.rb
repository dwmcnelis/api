class AddBuzzes < ActiveRecord::Migration
  def change
  	add_column :clients, :buzzes, :integer, after: :status
  end
end

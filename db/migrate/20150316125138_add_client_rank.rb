class AddClientRank < ActiveRecord::Migration
  def change
  	 add_column :clients, :rank, :integer, before: :status
  end
end

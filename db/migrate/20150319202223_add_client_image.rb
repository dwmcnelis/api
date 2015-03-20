class AddClientImage < ActiveRecord::Migration
  def change
  	add_column :clients, :image_uid,  :string
		add_column :clients, :image_name, :string 
  end
end

class AddClientImage < ActiveRecord::Migration
  def change
  	add_column :clients, :df_image_uid,  :string
		add_column :clients, :df_image_name, :string 
  end
end

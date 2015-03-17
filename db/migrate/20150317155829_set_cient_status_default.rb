class SetCientStatusDefault < ActiveRecord::Migration
  def change
  	change_column_default :clients, :status, 0 
  end
end

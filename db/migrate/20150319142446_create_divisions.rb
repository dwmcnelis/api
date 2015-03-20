class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions, id: :uuid do |t|
      t.string :short_name, limit: 254, default: nil
      t.string :full_name, limit: 254, default: nil
      t.uuid :user_id  # belongs_to :user
      t.integer :verified, limit: 1, null: false, default: 0
      t.timestamps
    end
  end
end

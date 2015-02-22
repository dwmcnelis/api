class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :username, limit: 254, default: nil
      t.string :first_name, limit: 40, default: nil
      t.string :last_name, limit: 40, default: nil
      t.date :dob
      t.integer :gender, limit: 2, null: false, default: 0
      t.integer :admin, limit: 1, null: false, default: 0
      t.integer :alpha, limit: 1, null: false, default: 0
      t.integer :beta, limit: 1, null: false, default: 0
      t.integer :banned, limit: 1, null: false, default: 0
      t.integer :tos, limit: 1, null: false, default: 0

      t.timestamps
    end
  end
end

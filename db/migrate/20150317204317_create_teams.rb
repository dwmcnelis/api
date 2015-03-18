class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, id: :uuid do |t|
      t.string :name, limit: 254, default: nil
      t.string :slug, limit: 254, default: nil
      t.integer :level, limit: 2, null: false, default: 0
      t.integer :type, limit: 2, null: false, default: 0
      t.uuid :league_id  # belongs_to :league
      t.uuid :division_id  # belongs_to :division
      t.date :founded
      t.string :location, limit: 254, default: nil
      t.string :arena, limit: 254, default: nil
      t.uuid :user_id  # belongs_to :user
      t.integer :verified, limit: 1, null: false, default: 0
      t.timestamps
    end
  end
end

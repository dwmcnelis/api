class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags, id: :uuid do |t|
      t.string :as, limit: 128, default: nil
      t.string :name, limit: 128, default: nil
      t.string :description, limit: 128, default: nil
      t.integer :taggings_count, default: 0
      t.string :image_uid, limit: 254, default: nil
      t.string :image_name, limit: 254, default: nil
      t.uuid :user_id  # belongs_to :user
      t.integer :verified, limit: 1, null: false, default: 0
      t.timestamps
    end

    add_index :tags, [:as, :name, :description], unique: true, name: 'tags_index'
  end
end

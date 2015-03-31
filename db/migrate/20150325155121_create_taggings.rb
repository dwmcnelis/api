class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings, id: :uuid do |t|
      t.string :as, limit: 128, default: nil
      t.uuid :tag_id  # belongs_to :tag
      t.string :tagged_type, limit: 128, default: nil  # belongs_to :tagged
      t.uuid :tagged_id  # belongs_to :tagged
      t.integer :importance, limit: 2, null: false, default: 0
      t.uuid :user_id  # belongs_to :user
      t.timestamps
    end

    add_index :taggings, [:as, :tag_id, :tagged_id, :tagged_type, :user_id], unique: true, name: 'taggings_index'
    add_index :taggings, [:as, :tagged_id, :tagged_type], name: 'taggings_tagged_index'
  end
end

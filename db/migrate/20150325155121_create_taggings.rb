class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings, id: :uuid do |t|
      t.string :as, limit: 128, default: nil
      t.uuid :tag_id  # belongs_to :tag
      t.uuid :tagged_id  # belongs_to :tagged
      t.string :tagged_type, limit: 128, default: nil  # belongs_to :tagged
      t.uuid :tagger_id  # belongs_to :tagger
      t.string :tagger_type, limit: 128, default: nil  # belongs_to :tagger
      t.integer :importance, limit: 2, null: false, default: 0
      t.uuid :user_id  # belongs_to :user
      t.timestamps
    end

    add_index :taggings, [:as, :tagged_id, :tagged_type], name: 'taggings_index'
    add_index :taggings, [:as, :tag_id, :tagged_id, :tagged_type, :tagger_id, :tagger_type], unique: true, name: 'taggings_unique_index'
  end
end

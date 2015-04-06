class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds, id: :uuid  do |t|
      t.integer :as
		  t.string :name
		  t.string :url
		  t.string :title
		  t.string :description
		  t.string :feed_url
		  t.string :type, limit: 40, default: nil
		  t.string :etag
		  t.uuid :user_id  # belongs_to :user
		  t.datetime :last_modified_at
		  t.datetime :aggregated_at

		  t.timestamps
    end

    add_index :feeds, :url
    add_index :feeds, :last_modified_at
    add_index :feeds, :aggregated_at
  end
end

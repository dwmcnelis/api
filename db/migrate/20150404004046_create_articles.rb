class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles, id: :uuid  do |t|
      t.integer :as
		  t.string :title
		  t.string :url
		  t.string :author
		  t.text :summary
		  t.text :content
		  t.string :image
		  t.string :categories
		  t.string :entry_id
      t.integer :tagged, limit: 1, null: false, default: 0
    	t.uuid :feed_id  # belongs_to :feed
		  t.uuid :user_id  # belongs_to :user
		  t.datetime :published_at
		  t.datetime :aggregated_at

		  t.timestamps
    end

  	add_index :articles, :entry_id
  	add_index :articles, :feed_id
  	add_index :articles, :published_at
  	add_index :articles, :aggregated_at
  end
end

# app/models/article.rb

class Article < ActiveRecord::Base

  include Concerns::AsEnum

  enum as: as_enum

  belongs_to :feed
  belongs_to :user

  serialize :categories, Array

  #validates_presence_of :as
  validates_presence_of :url
  validates_uniqueness_of :url
  #validates_length_of :name, maximum: 128
  validates_presence_of :entry_id
  validates_uniqueness_of :entry_id

  scope :user_is, ->(user) { where(user: user) }
  scope :no_user, -> { where(user_id: nil) }

  class << self

    def search(query)
      query = "%#{query}%"
      title = arel_table[:title].matches(query)
      summary = arel_table[:summary].matches(query)
      content = arel_table[:content].matches(query)
      where(ntitleame.or(summary).or(content))
    end

    def find_or_create(entry_id, options={})
      Article.where(entry_id: entry_id).first || create(options.merge({entry_id: entry_id}))
    end

  end # class << self

  def to_s
    name
  end

  def owner?(user)
    self.user_id == user.id
  end

  def unowned?
    self.user_id.nil?
  end

end
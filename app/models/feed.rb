# app/models/feed.rb

class Feed < ActiveRecord::Base

  include Concerns::AsEnum

  enum as: as_enum

  belongs_to :user
  has_many :articles

  #validates_presence_of :as
  validates_presence_of :name
  validates_length_of :name, maximum: 128
  validates_presence_of :url
  validates_uniqueness_of :url

  scope :user_is, ->(user) { where(user: user) }
  scope :no_user, -> { where(user_id: nil) }

  class << self

    def search(query)
      query = "%#{query}%"
      name = arel_table[:name].matches(query)
      description = arel_table[:description].matches(query)
      where(name.or(description))
    end

    def find_or_create(as, name, url, user_id=nil)
      Feed.where(url: url).first || create(as: as, name: name, url: url, user_id: user_id)
    end

    def uuid(*args)
      sha2 = Digest::SHA2.new
      args.each do |arg|
        sha2.update arg.to_s
      end
      digest = sha2.hexdigest.last(32)
      "#{digest.first(8)}-#{digest[8..11]}-#{digest[12..15]}-#{digest[16..19]}-#{digest.last(12)}"
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

  def get
    @get ||= RestClient.get(self.url) do |response, request, result, &block|
      @gotten_at = Time.zone.now
      case response.code
      when 200
        response
      # when 423
      #   raise SomeCustomExceptionIfYouWant
      else
        response.return!(request, result, &block)
      end
    end
  end

  def parsed
    @parsed ||= Feedjira::Feed.parse(self.get)
  end

  def modified?
    self.last_modified_at.nil? || (self.parsed.last_modified > self.last_modified_at)
  end

  def aggregate!
    if self.modified?
      self.parsed.entries.each do |entry|
        uuid = entry.entry_id ? entry.entry_id : Feed.uuid(entry.title, entry.url, entry.published)
        Article.find_or_create(uuid,
          as: self.as,
          title: entry.title,
          url: entry.url,
          author: entry.author,
          summary: entry.summary,
          content: entry.content,
          image: entry.image,
          categories: entry.categories,
          tagged: false,
          entry_id: uuid,
          feed_id: self.id,
          user_id: self.user_id,
          published_at: entry.published,
          aggregated_at: @gotten_at
        )
      end
      self.last_modified_at = self.parsed.last_modified
      self.aggregated_at = @gotten_at
      self.save!
      self
    end
  end

end
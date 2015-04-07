# app/models/client.rb

# Client
#

class Client < ActiveRecord::Base

  include Concerns::ClientLevelEnum
  include Concerns::ClientStatusEnum

	enum level: level_enum
	enum status: status_enum

  dragonfly_accessor :image

  belongs_to :user

  has_many :taggings, as: :tagged, dependent: :destroy, class_name: 'Tagging'
  has_many :tags, -> { uniq }, through: :taggings, source: :tag, class_name: 'Tag'

  scope :user_is, ->(user) { where(user: user) }
  scope :no_user, -> { where(user_id: nil) }

  class << self

    # Search by first or last name
    #
    # @param [String] query
    #
    # @return [ActiveRecord_Relation] scope
    #    
    def search(query)
		  query = "%#{query}%"
		  first_name = arel_table[:first_name].matches(query)
		  last_name = arel_table[:last_name].matches(query)
		  where(first_name.or(last_name))
		end

	end # class << self

  def owner?(user)
    self.user_id == user.id
  end

  def unowned?
    self.user_id.nil?
  end

  def full_name
    (!self.first_name.blank? ? self.first_name : '') + ' ' + (!self.last_name.blank? ? self.last_name : '')
  end

  def sort_name
    (!self.last_name.blank? ? self.last_name : '') + (!self.first_name.blank? ? ', '+ self.first_name : '')
  end

  # Update tags by adding/removing taggings as appropriate
  #
  # @param [Array<String>] tag_ids
  # @param [String] user_id
  #
  # :nocov:
  def update_tags(tag_ids, user_id)
    now = tag_ids
    was = self.taggings.map(&:tag_id)
    keep = now & was
    remove = was - now
    add = now - was

    self.taggings.where(tag_id: remove).each do |tagging|
      tagging.destroy
    end

    add.each do |tag_id|
      tag = Tag.find_by_id(tag_id)
      Tagging.create(as: tag.as, tag_id: tag_id, tagged_type: self.class.name, tagged_id: self.id, user_id: user_id)
    end
  end
  # :nocov:


  # Image as dragonfly attachment with static fallback
  # so you can chain :process, :thumb, :url, etc.
  #
  # @return [Dragonfly::Attachment]
  # :nocov:
  def image_attachment
    if self.image && self.image.image
      self.image
    else
      Dragonfly.app(:static).fetch_file(File.join(Rails.root, 'app/assets/images/client-no-image.png'))
    end
  end
  # :nocov:
end

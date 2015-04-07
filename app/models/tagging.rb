# app/models/tagging.rb

class Tagging < ActiveRecord::Base

    include Concerns::AsEnum

    enum as: as_enum

    belongs_to :tag, counter_cache: true
    belongs_to :tagged, polymorphic: true

    belongs_to :user

    #validates_presence_of :as
    validates_presence_of :tag_id

    validates_uniqueness_of :tag_id, scope: [:as, :tag_id, :tagged_id, :tagged_type, :user_id]

    after_destroy :remove_unused_tags

    scope :tagged_is, ->(tagged) { where(tagged: tagged) }
    scope :no_tagged, -> { where(tagged_id: nil, tagged_type: nil) }

    scope :user_is, ->(user) { where(user: user) }
    scope :no_user, -> { where(user_id: nil) }

    scope :tagged_as_any, ->(as = ['type']) { where(as: as) }
    scope :tagged_as, ->(as = 'type') { tagged_as_any(as.to_s) }

    class << self

    end # class << self

    private

    # :nocov:
    def remove_unused_tags
        if true
          tag.destroy if tag.reload.taggings_count.zero?
        else
          tag.destroy if tag.reload.taggings.count.zero?
        end
    end
    # :nocov:
end

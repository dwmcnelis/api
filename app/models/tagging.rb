class Tagging < ActiveRecord::Base

    belongs_to :tag, counter_cache: true
    belongs_to :tagged, polymorphic: true
    belongs_to :tagger, polymorphic: true
    belongs_to :user

    #validates_presence_of :as
    validates_presence_of :tag_id

    validates_uniqueness_of :tag_id, scope: [:as, :tagged_type, :tagged_id, :tagger_type, :tagger_id]

    after_destroy :remove_unused_tags

    scope :tagger_is, ->(tagger) { where(tagger: tagger) }
    scope :no_tagger, -> { where(tagger_id: nil, tagger_type: nil) }

    scope :tagged_is, ->(tagged) { where(tagged: tagged) }
    scope :no_tagged, -> { where(tagged_id: nil, tagged_type: nil) }

    scope :user_is, ->(user) { where(user: user) }
    scope :no_user, -> { where(user_id: nil) }

    scope :tagged_as_any, ->(as = ['type']) { where(as: as) }
    scope :tagged_as, ->(as = 'type') { tagged_as_any(as.to_s) }

    class << self

        def search(query) 
          where(arel_table[:as].matches("%#{query}%"))
        end

    end # class << self

    private

    def remove_unused_tags
        if true
          tag.destroy if tag.reload.taggings_count.zero?
        else
          tag.destroy if tag.reload.taggings.count.zero?
        end
    end
end

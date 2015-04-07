# app/models/team.rb

# Team (sports)
#

class Team < ActiveRecord::Base

  include Concerns::TeamLevelEnum
  include Concerns::TeamKindEnum

	enum level: level_enum
	enum kind: kind_enum

  belongs_to :league
  belongs_to :division
  belongs_to :conference
  belongs_to :user

  has_many :taggings, as: :tagged, dependent: :destroy
  has_many :base_tags, through: :taggings, source: :tag


  before_save :slugify

  scope :user_is, ->(user) { where(user: user) }
  scope :no_user, -> { where(user_id: nil) }

  class << self

    # Find or create by name,level,kind
    #
    # @param [String] name
    # @param [String] level
    # @param [String] kind
    #
    def find_or_create(name, level, kind, options={})
      user_id ||= options[:user_id]
      user_id ||= options[:user] ? options[:user].id : nil
      Team.where(name: name, level: Team.levels[level], kind: Team.kinds[kind]).first || create(name: name, level: level, kind: kind, user_id: user_id)
    end

    # Slugify name
    #
    # @param [String] name
    #
    # @return [String] slug
    #
  	def slugify(name)
	  	# strip the string
	    slug = name.strip

	    # remove apostrophes and periods
	    slug.gsub! /['`\.]/,""

	    # @ --> at, and & --> and
	    slug.gsub! /\s*@\s*/, " at "
	    slug.gsub! /\s*&\s*/, " and "

	    # replace all non alphanumeric, underscore or periods with underscore
     	slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  

			# convert double underscores to single
			slug.gsub! /_+/,"_"

			# strip off leading/trailing underscore
			slug.gsub! /\A[_\.]+|[_\.]+\z/,""

			# downcase
			slug.downcase!

			slug
  	end

    # Search by name or aliases
    #
    # @param [String] query
    #
    # @return [ActiveRecord_Relation] scope
    #    
  	def search(query)
		  query = "%#{query}%"
		  name = arel_table[:name].matches(query)
		  aliases = arel_table[:aliases].matches(query)
		  where(name.or(aliases))
		end

  end # class << self

  def owner?(user)
    self.user_id == user.id
  end

  def unowned?
    self.user_id.nil?
  end

  def slugify
  	self.slug = self.class.slugify(self.name)
  end

	def grouping
		return "#{self.league.short_name} #{self.kind}" if self.league 
		return "#{self.division.short_name} #{self.kind}" if self.division 
		return "#{self.conference.short_name} #{self.kind}" if self.conference 
		nil
  end

end # Team

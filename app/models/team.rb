class Team < ActiveRecord::Base

	enum level: {professional: 0, olympic: 1, college: 2, high_school: 3, middle_school: 4, town: 5, club: 6, other_level: 32767}
	enum kind: {football: 0, soccer: 1, basketball: 2, baseball: 3, softball: 4, hockey: 5, other_type: 32767}

  has_one :user

  before_save :slugify

  class << self
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
  end

  def owner?(user)
    self.user_id == user.id
  end

  def slugify
  	self.slug = self.class.slugify(self.name)
  end
end

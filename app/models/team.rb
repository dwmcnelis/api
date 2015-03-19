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

  	def search(query)
		  query = "%#{query}%"
		  name_match = arel_table[:name].matches(query)
		  aliases_match = arel_table[:aliases].matches(query)
		  where(name_match.or(aliases_match))
		end

		def select2(teams)
			{"select_#{Team.to_s.downcase.pluralize}":
				teams.to_a.group_by do |team|
				 #{}"#{team.league.upcase} #{team.kind.upcase}"
				 "NFL #{team.kind.upcase}"
				end.inject([]) do |result, pair|
					group = pair[0]
					teams = pair[1]
					puts "group: #{group} teams.count: #{teams.count}"
					result << {
						id: 0,
						text: group,
						children: teams.map do |team|
							{id: team.id, text: team.name, description: team.kind}
						end
					}
					result
				end
			}
		end
  end # class << self

  def owner?(user)
    self.user_id == user.id
  end

  def slugify
  	self.slug = self.class.slugify(self.name)
  end
end # Team

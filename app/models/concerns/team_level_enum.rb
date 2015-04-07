# app/models/concerns/team_level_enum.rb

# Team level enumeration
#

module Concerns

  module TeamLevelEnum

    extend ActiveSupport::Concern

	  module ClassMethods
	    def level_enum
				{other_level: 0, professional: 1, olympic: 2, college: 3, high_school: 4, middle_school: 5, town: 6, club: 7}
	    end

		  # :nocov:
	    def level_code(value)
	    	level_enum[value.to_sym]
	    end
		  # :nocov:

		  # :nocov:
	    def level_value(code)
	    	level_enum.invert[code]
			end
		  # :nocov:
	  end

	end # TeamLevelEnum
end # Concerns

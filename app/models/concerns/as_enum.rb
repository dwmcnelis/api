# app/models/concerns/as_enum.rb

# Categorized as enumeration
#

module Concerns

  module AsEnum

    extend ActiveSupport::Concern

	  module ClassMethods
	    def as_enum
				{ other: 0, people: 1, sports: 2, music: 3, entertainment: 4, food: 5, travel: 6, politics: 7}
	    end

		  # :nocov:
	    def as_code(value)
	    	as_enum[value.to_sym]
	    end
		  # :nocov:

		  # :nocov:
	    def as_value(code)
	    	as_enum.invert[code]
			end
		  # :nocov:
	  end

	end # AsEnum
end # Concerns

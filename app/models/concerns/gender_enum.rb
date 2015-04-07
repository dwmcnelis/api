# app/models/concerns/gender_enum.rb

module Concerns

  module GenderEnum

    extend ActiveSupport::Concern

	  module ClassMethods
	    def gender_enum
				{ male: 0, female: 1, unknown: 2}
	    end

		  # :nocov:
	    def gender_code(value)
	    	gender_enum[value.to_sym]
	    end
		  # :nocov:

		  # :nocov:
	    def gender_value(code)
	    	gender_enum.invert[code]
			end
		  # :nocov:
	  end

	end # GenderEnum
end # Concerns

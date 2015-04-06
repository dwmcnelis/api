# app/models/concerns/gender_enum.rb

module Concerns

  module GenderEnum

    extend ActiveSupport::Concern

	  module ClassMethods
	    def gender_enum
				{ male: 0, female: 1, unknown: 2}
	    end

	    def gender_code(value)
	    	gender_enum[value.to_sym]
	    end

	    def gender_value(code)
	    	gender_enum.invert[code]
			end
	  end

	end # GenderEnum
end # Concerns

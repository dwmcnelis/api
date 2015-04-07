# app/models/concerns/team_kind_enum.rb

module Concerns

  module TeamKindEnum

    extend ActiveSupport::Concern

	  module ClassMethods
	    def kind_enum
				{other_kind: 0, football: 1, soccer: 2, basketball: 3, baseball: 4, softball: 5, hockey: 6}
	    end

		  # :nocov:
	    def kind_code(value)
	    	kind_enum[value.to_sym]
	    end
		  # :nocov:

		  # :nocov:
	    def kind_value(code)
	    	kind_enum.invert[code]
			end
		  # :nocov:
	  end

	end # TeamKindEnum
end # Concerns

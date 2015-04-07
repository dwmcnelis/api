# app/models/concerns/client_level_enum.rb

module Concerns

  module ClientLevelEnum

    extend ActiveSupport::Concern

	  module ClassMethods
	    def level_enum
				{ a_list: 0, b_list: 1, c_list: 2}
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

	end # ClientLevelEnum
end # Concerns

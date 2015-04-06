# app/models/concerns/client_level_enum.rb

module Concerns

  module ClientLevelEnum

    extend ActiveSupport::Concern

	  module ClassMethods
	    def level_enum
				{ a_list: 0, b_list: 1, c_list: 2}
	    end

	    def level_code(value)
	    	level_enum[value.to_sym]
	    end

	    def level_value(code)
	    	level_enum.invert[code]
			end
	  end

	end # ClientLevelEnum
end # Concerns

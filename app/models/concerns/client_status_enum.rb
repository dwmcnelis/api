# app/models/concerns/client_status_enum.rb

module Concerns

  module ClientStatusEnum

    extend ActiveSupport::Concern

	  module ClassMethods
	    def status_enum
				{ initial: 0, verified: 1, qualified: 2, disqualified: 3, inactive: 4, active: 5}
	    end

	    def status_code(value)
	    	status_enum[value.to_sym]
	    end

	    def status_value(code)
	    	status_enum.invert[code]
			end
	  end

	end # ClientStatusEnum
end # Concerns

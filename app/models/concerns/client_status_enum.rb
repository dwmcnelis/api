# app/models/concerns/client_status_enum.rb

# Client status enumeration
#

module Concerns

  module ClientStatusEnum

    extend ActiveSupport::Concern

	  module ClassMethods
	    def status_enum
				{ initial: 0, verified: 1, qualified: 2, disqualified: 3, inactive: 4, active: 5}
	    end

		  # :nocov:
	    def status_code(value)
	    	status_enum[value.to_sym]
	    end
		  # :nocov:

		  # :nocov:
	    def status_value(code)
	    	status_enum.invert[code]
			end
		  # :nocov:
	  end

	end # ClientStatusEnum
end # Concerns

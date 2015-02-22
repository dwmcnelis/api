module Concerns

  module Parameters

    extend ActiveSupport::Concern

    included do

      helpers do

        def permitted_params
          @permitted_params ||= declared(params, include_missing: false, include_parent_namespaces: false)
        end

      end

    end

  end # Parameters

end # Concerns

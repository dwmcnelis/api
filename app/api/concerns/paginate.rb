# app/api/concerns/paginate.rb

# Pagination helper for API
#

module Concerns

  module Paginate

    extend ActiveSupport::Concern

    included do

      helpers do

        # Paginate collection via Kaminari and set headers as necessary
        #
        # @param [ActiveRecord_Relation] collection
        #
        # @param [ActiveRecord_Relation] paginated collection
        #
        def paginate(collection)
          if [:page, :per_page, :offset].any? { |key| params.key?(key) }
            collection.page(params[:page].to_i).per(params[:per_page].to_i).padding(params[:offset].to_i).tap do |data|
              header "X-Total", data.total_count.to_s
              header "X-Total-Pages", data.num_pages.to_s
              header "X-Per-Page", params[:per_page].to_s
              header "X-Page", data.current_page.to_s
              header "X-Next-Page", data.next_page.to_s
              header "X-Prev-Page", data.prev_page.to_s
              header "X-Offset", params[:offset] ? params[:offset].to_s : '0'
            end
          else
            collection.all
          end
        end

      end

      # Pagination parameter declaration helper
      #
      # @option options [Fixnum] :per_page records per page
      # @option options [Fixnum] :max_per_page maximum records per page
      # @option options [Fixnum] :offset offset records from start
      #
      # @param [ActiveRecord_Relation] paginated collection
      #
      def self.pagination(options = {})
        options.reverse_merge!(
          per_page: ::Kaminari.config.default_per_page || 10,
          max_per_page: ::Kaminari.config.max_per_page,
          offset: 0
        )
        params do
          optional :page, type: Integer, desc: 'Page offset to fetch.'
          optional :per_page, type: Integer, desc: 'Number of results to return per page.', max_value: options[:max_per_page]
          if options[:offset].is_a? Numeric
            optional :offset, type: Integer, desc: 'Pad a number of results.'
          end
        end
      end

    end

    # Pagination maximum value validator
    #
    class MaxValueValidator < Grape::Validations::Base
      def validate_param!(attr_name, params)
        return unless params[attr_name]

        attr = params[attr_name]
        if attr && @option && attr > @option
          raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "must be less than #{@option}"
        end
      end
    end

  end # Paginate

end # Concerns

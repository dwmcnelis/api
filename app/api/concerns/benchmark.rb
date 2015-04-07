# app/api/concerns/benchmark.rb

require 'benchmark'

module Concerns

  module Benchmark

    extend ActiveSupport::Concern

    included do

      helpers do

        # Is benchmarking enabled?
        #
        # @return [Boolean] is enabled
        def benchmarking?
          Rails.env == 'development'
        end

        # Conditionally benchmark block
        #
        # @param [Lambda] block
        # :nocov:
        def benchmark(&block)
          if benchmarking?
            response = nil
            elapsed = ::Benchmark.realtime do
              response = yield block
            end * 1000
            Rails.logger.info "#{env['REQUEST_METHOD']} \"#{env['REQUEST_URI']}\"" + " (#{sprintf('%.2f', elapsed)}ms)".colorize(elapsed > 1000.0 ? :red : (elapsed > 500.0 ? :yellow : :green))
            response
          else
            yield block
          end
        end
        # :nocov:

      end

    end

  end # Benchmark

end # Concerns


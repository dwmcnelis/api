# api/logger.rb

require 'grape/middleware/globals'

class ApiLogger < Grape::Middleware::Base

  def before
    super
    debugger
    puts "[api] Requested#{request_log}" unless request_log.nil? || request_log.empty?
    puts "[api] HEADERS: #{@env['grape.request.headers']}" unless @env['grape.request.headers'].nil? || @env['grape.request.headers'].empty?
    puts "[api] PARAMS: #{@env['grape.request.params']}" unless @env['grape.request.params'].nil? || @env['grape.request.params'].empty?
  end

  def after
    #response_body = JSON.parse(response.body.first)
    #if response_body.is_a?(Hash)
      # Rails.logger.debug "[api] RespType: #{response_body['response_type']}" unless response_body['response_type'].blank?
      # Rails.logger.debug "[api] Response: #{response_body['response']}" unless response_body['response'].blank?
      # Rails.logger.debug "[api] Backtrace:\n#{response_body['backtrace'].join("\n")}" if response_body['backtrace'] && response_body['backtrace'].any?
    #end
    super
  end

  private

      def request_log
        @request_log ||= begin
          res = ''
          res << " #{request_log_data}" unless request_log_data.nil? || request_log_data.empty?
          res
        end
      end

      def request_log_data
        rld = {}

        x_org = env['HTTP_X_ORGANIZATION']

        rld[:user_id] = current_user.id if current_user
        rld[:x_organization] = x_org if x_org

        rld
      end

      def current_user
        false
      end
 
  # def request_log_data
  #   request_data = {
  #     method: env['REQUEST_METHOD'],
  #     path:   env['PATH_INFO'],
  #     query:  env['QUERY_STRING']
  #   }
  #   #request_data[:user_id] = current_user.id if current_user
  #   request_data
  # end
 
  # def response_log_data
  #   {
  #     #description: env['api.endpoint'].options[:route_options][:description],
  #     #source_file: env['api.endpoint'].block.source_location[0][(Rails.root.to_s.length+1)..-1],
  #     #source_line: env['api.endpoint'].block.source_location[1]
  #   }
  # end
 
end


  # def initialize(app)
  #   @app = app
  # end
 
  # def call(env)
  #   payload = {
  #     remote_addr:    env['REMOTE_ADDR'],
  #     request_method: env['REQUEST_METHOD'],
  #     request_path:   env['PATH_INFO'],
  #     request_query:  env['QUERY_STRING'],
  #     x_organization: env['HTTP_X_ORGANIZATION']
  #   }

  #   puts payload.inspect
 
    # ActiveSupport::Notifications.instrument "grape.request", payload do
    #   @app.call(env).tap do |response|
    #     payload[:params] = env["api.endpoint"].params.to_hash
    #     payload[:params].delete("route_info")
    #     payload[:params].delete("format")
    #     payload[:response_status] = response[0]
    #   end
    # end
#  end
#end
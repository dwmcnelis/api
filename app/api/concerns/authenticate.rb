# app/api/concerns/authenticate.rb

# Authentication helper for API
#

require 'token'

module Concerns

  module Authenticate

    extend ActiveSupport::Concern

    included do

      helpers do

        # Extract authorization bearer jwt token from header
        #
        # @return [String] token
        #
        def authorization_token
          @authorization_token ||= begin
            if request.headers['Authorization'].present?
              pieces = request.headers['Authorization'].split(' ')
              pieces.length == 2 && pieces[0] == 'Bearer' ? pieces[1] : nil
            end
          end
        end

        # Prepare parsed jwt token
        #
        # @return [Token] token
        #
        def token
          @token ||= begin
            Token.new(encoded: authorization_token)
          end
        end

        # Find current user from jwt token
        #
        # @return [User] current user
        #
        def current_user
          @current_user ||= begin
            User.find_by_token(authorization_token)
          end
        end

        # Authenticate or force error
        #
        def authenticate!
          error!({error: 'Unauthorized',
                  detail: "Not authorized for route '#{request.request_method} #{request.path}'",
                  status: '401'},
                 401) unless current_user

        end

      end

    end

  end # Authenticate

end # Concerns

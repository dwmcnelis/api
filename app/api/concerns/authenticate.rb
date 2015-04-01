# app/api/concerns/authenticate.rb

require 'token'

module Concerns

  module Authenticate

    extend ActiveSupport::Concern

    included do

      helpers do

        def authorization_token
          @authorization_token ||= begin
            if request.headers['Authorization'].present?
              pieces = request.headers['Authorization'].split(' ')
              pieces.length == 2 && pieces[0] == 'Bearer' ? pieces[1] : nil
            end
          end
        end

        def token
          @token ||= begin
            Token.new(encoded: authorization_token)
          end
        end

        def current_user
          @current_user ||= begin
            User.find_by_token(authorization_token)
          end
        end

        def authenticate!
          error!({ error:  'Unauthorized',
                   detail: "Not authorized for route '#{request.request_method} #{request.path}'",
                   status: '401'},
                 401) unless current_user

        end

      end

    end

  end # Authenticate

end # Concerns

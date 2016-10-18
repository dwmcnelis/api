# app/api/api.rb

# ClientBuzz API
#

class API < Grape::API

  include Concerns::Authenticate
  include Concerns::Authorize
  include Concerns::Benchmark
  include Concerns::Paginate
  include Concerns::Parameters

  TOKEN_DURATION = 15*60*1000  # Fifteen minutes in milliseconds
  UUID_REGEXP = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/

  prefix ''
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers

  rescue_from :all
  error_formatter :json, ApiErrorFormatter

  mount V1::Authorization
  mount V1::Attachments
  mount V1::Clients
  mount V1::Tags
  mount V1::Teams

  # 404 error for '/'
  route :any, '/' do
    error!({ error:  'Not Found',
             detail: "No such route '#{request.request_method} #{request.path}'",
             status: '404'},
           404)
  end

  # 404 error for all unmatched routes except '/'
  route :any, '*path' do
    error!({ error:  'Not Found',
             detail: "No such route '#{request.request_method} #{request.path}'",
             status: '404'},
           404)
  end

end # API
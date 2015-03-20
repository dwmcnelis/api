require 'dragonfly'

# Dragonfly default 
Dragonfly.app.configure do
  plugin :imagemagick

  secret Rails.application.secrets.secret_key_base

  url_format "/content/:job/:name"

  datastore :file, root_path: Rails.root.join('dragonfly'), server_root: Rails.root.join('content')
end

# Dragonfly static
Dragonfly.app(:static).configure do
  plugin :imagemagick

  secret Rails.application.secrets.secret_key_base

  url_format "/static/:job/:name"

  fetch_file_whitelist [Regexp.new(Rails.root.join('app/assets/images').to_s+'.*')]

  datastore :memory # storing not intended
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
#Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end



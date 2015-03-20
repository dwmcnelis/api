Rails.application.routes.draw do

	# Grape API
  mount API => '/'

  # Dragonfly default
  mount Dragonfly.app => '/'
  get '/content/thumb/:geometry/:job/*file_name' => Dragonfly.app.endpoint { |params, app|
    job = Dragonfly::Job.deserialize(params[:job], app)
    job.validate_sha!(params[:sha])
    job.thumb(params[:geometry]).apply
  }

  # Dragonfly static
  get '/static/:job/*file_name' =>  Dragonfly.app(:static)
  get '/static/thumb/:geometry/:job/*file_name' => Dragonfly.app.endpoint { |params, app|
    job = Dragonfly::Job.deserialize(params[:job], app)
    job.validate_sha!(params[:sha])
    job.thumb(params[:geometry]).apply
  }

end

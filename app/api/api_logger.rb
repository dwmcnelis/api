# app/api/api_logger.rb

class ApiLogger < Grape::Middleware::Base

  def before
    super
    request = Grape::Request.new(@env)
    logger.info "[api] request: #{request.request_method} #{request.scheme}://#{request.host}:#{request.port}/#{request.path_info} #{request.query_string} for #{request.ip}"
    request.headers.each do |key,value|
      logger.info "[api] request header: #{key}: #{value}"
    end
    content_length = request.content_length.to_i
    content_type = request.content_type
    if content_length > 0
      logger.info "[api] request content length: #{content_length}"
      logger.info "[api] request content type: #{content_type}"
      if content_type == 'application/json'
        json_pp(request.body.string).split("\n").each do |line|
         logger.info "[api] request body: #{line}"
        end
      else
        logger.info "[api] request body: #{request.body.string}"
      end
    end
  end

  def after
    response = instance_variable_get("@app_response")
    status = response[0].to_i
    logger.info "[api] response status: #{status}"
    headers = response[1]
    headers.each do |key,value|
      logger.info "[api] response header: #{key}: #{value}"
    end

    content_length = headers['Content-Length'].to_i
    content_type = headers['Content-Type']
    if content_length > 0
      if content_type == 'application/json'
        body = response[2].body.join('')
        json_pp(body).split("\n").each do |line|
          logger.info "[api] response body: #{line}"
        end
      end
    end
    super
  end

  private

  def logger
    Rails.logger
  end

  def json_pp(body)
    begin
      body = body.to_json if body.kind_of?(Hash)
      JSON.pretty_generate(JSON.parse(body))
    rescue JSON::ParserError
      body
    end
  end
 
end

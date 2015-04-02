# app/api/api_logger.rb

require 'colorize'

class ApiLogger < Grape::Middleware::Base

  PREFIX_COLOR = :default 
  REQUEST_COLOR = :light_blue
  RESPONSE_COLOR = :light_yellow

  def before
    super
    request = Grape::Request.new(@env)
    logger.info "[api]< ".colorize(PREFIX_COLOR)+"#{request.request_method} #{request.scheme}://#{request.host}:#{request.port}/#{request.path_info} #{request.query_string} for #{request.ip}".colorize(REQUEST_COLOR)
    request.headers.each do |key,value|
      logger.info "[api]< ".colorize(PREFIX_COLOR)+"#{key}: #{value}".colorize(REQUEST_COLOR)
    end
    content_length = request.content_length.to_i
    content_type = request.content_type
    if content_length > 0
      logger.info "[api]< ".colorize(PREFIX_COLOR)+"Content-Length: #{content_length}".colorize(REQUEST_COLOR)
      logger.info "[api]< ".colorize(PREFIX_COLOR)+"Content-Type: #{content_type}".colorize(REQUEST_COLOR)
      if content_type =~ /application\/json/
        json_pp(request.body.string).split("\n").each do |line|
         logger.info "[api]< ".colorize(PREFIX_COLOR)+"#{line}".colorize(REQUEST_COLOR)
        end
      else
        logger.info "[api]< ".colorize(PREFIX_COLOR)+"#{request.body.string}".colorize(REQUEST_COLOR)
      end
    end
  end

  def after
    response = instance_variable_get("@app_response")
    status = response[0].to_i
    logger.info "[api]> ".colorize(PREFIX_COLOR)+"Status: #{status}".colorize(RESPONSE_COLOR)
    headers = response[1]
    headers.each do |key,value|
      logger.info "[api]> ".colorize(PREFIX_COLOR)+"#{key}: #{value}".colorize(RESPONSE_COLOR)
    end

    content_length = headers['Content-Length'].to_i
    content_type = headers['Content-Type']
    if content_length > 0
      if content_type =~ /application\/json/
        body = response[2].body.join('')
        json_pp(body).split("\n").each do |line|
          logger.info "[api]> ".colorize(PREFIX_COLOR)+"#{line}".colorize(RESPONSE_COLOR)
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

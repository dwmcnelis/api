# api/logger.rb

#require 'grape/middleware/globals'

class ApiLogger < Grape::Middleware::Base

  def before
    super
    req = Grape::Request.new(@env)
     # :params, :headers, :env, :body, :script_name, :path_info, :request_method, :query_string, 
     # :content_length, :content_type, :session, :session_options, :logger, :media_type, :media_type_params,
     # :content_charset, :scheme, :ssl?, :host_with_port, :port, :host, :script_name=, :path_info=, :delete?,
     # :get?, :head?, :options?, :link?, :patch?, :post?, :put?, :trace?, :unlink?, :form_data?, 
     #:parseable_data?, :GET, :POST, :update_param, :delete_param, :[], :[]=, :values_at, :referer, :referrer,
     # :user_agent, :cookies, :xhr?, :base_url, :url, :path, :fullpath, :accept_encoding, :accept_language,
     # :trusted_proxy?, :ip, :split_ip_addresses, :reject_trusted_ip_addresses, :parse_query, :parse_multipart,
     # :parse_http_accept_header
    logger.info "[api] request: #{req.request_method} #{req.scheme}://#{req.host}:#{req.port}/#{req.path_info} #{req.query_string} for #{req.ip}"
    req.headers.each do |key,value|
      logger.info "[api] request header: #{key}: #{value}"
    end
    content_length = req.content_length.to_i
    content_type = req.content_type
    if content_length > 0
      logger.info "[api] request content length: #{content_length}"
      logger.info "[api] request content type: #{content_type}"
      if content_type == 'application/json'
        json_pp(req.body.string).split("\n").each do |line|
         logger.info "[api] request body: #{line}"
        end
      else
        logger.info "[api] request body: #{req.body.string}"
      end
    end
  end

  def after
    response = instance_variable_get("@app_response").last
    logger.info "[api] response status: #{response.status}"
    response.headers.each do |key,value|
      logger.info "[api] response header: #{key}: #{value}"
    end

    content_length = response.headers['Content-Length'].to_i
    content_type = response.headers['Content-Type']
    if content_length > 0
      if content_type == 'application/json'
        json_pp(response.body.join('')).split("\n").each do |line|
          logger.info "[api] response body: #{line}"
        end
      else
        logger.info "[api] response body: #{response.body.join('')}"
      end
    end

    #response_body = JSON.parse(response.body.first)
    #if response_body.is_a?(Hash)
      # Rails.logger.debug "[api] RespType: #{response_body['response_type']}" unless response_body['response_type'].blank?
      # Rails.logger.debug "[api] Response: #{response_body['response']}" unless response_body['response'].blank?
      # Rails.logger.debug "[api] Backtrace:\n#{response_body['backtrace'].join("\n")}" if response_body['backtrace'] && response_body['backtrace'].any?
    #end
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

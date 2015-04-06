# app/api/api_error_formatter.rb

module ApiErrorFormatter
  def self.call(message, backtrace, options, env)
    if message.kind_of?(String)
    	if Rails.env == 'development' || Rails.env == 'test'
    		{
	        error:  'Exception',
	        detail: "#{message}",
	        backtrace: "#{backtrace.first} ...",
	        status: '500'
      	}.to_json
    	else
    		{
	        error:  'Exception',
	        detail: 'Something unexpected went wrong',
	        status: '500'
      	}.to_json
    	end
    else
      message.to_json
    end
  end
end

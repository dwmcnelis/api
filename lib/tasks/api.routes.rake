require 'rake'

desc 'Describe API'
task :'api:routes' => :environment do
  API.routes.each do |route|
    if route.route_method
      route_path = route.route_path
      route_method = route.route_method
      route_version = route.route_version
      route_params = route.route_params
      route_description = route.route_description
      route_requirements = route.route_requirements
      route_namespace = route.route_namespace
      route_formatted_path = route_path
      route_formatted_path = route_formatted_path.gsub('(.:format)', '')
      route_formatted_path = route_formatted_path.gsub(':version', route.route_version) if route_version
      puts "#{route_method} #{route_formatted_path}"
      puts "  #{route_description}" if route_description
      puts '  Parameters:'
      #puts '    key  |String|  (required)  Consumer access key'
      #puts '    signature  |String|  (required)  Consumer access signature'
      if route_params.is_a?(Hash)
        route_params.each do |param_name, param|
          param_type = param.is_a?(Hash) ? param[:type] : nil
          param_required = param.is_a?(Hash) ? param[:required] : nil
          param_regexp = param.is_a?(Hash) ? param[:regexp] : nil
          param_description = param.is_a?(Hash) ? param[:desc] : nil
          param_example = param.is_a?(Hash) ? param[:example] : nil
          puts "    #{param_name}#{param_type ? '  |'+param_type.to_s+'|' : ''}#{param_regexp ? '  '+param_regexp.inspect+'' : ''}#{param_example ? '  <'+param_example.to_s+'>' : ''}#{param_required ? '  (required)' : ''}#{param_description ? '  '+param_description.to_s : ''}"
        end
      end
      puts ''
    end
  end
end

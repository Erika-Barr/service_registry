require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = :json
  config.curl_host = 'http://localhost:3000' # Will be used in curl request
  config.api_name = "Service Registry API" # Your API name
  config.request_headers_to_include = ["Host", "Content-Type"]
  config.response_headers_to_include = ["Host", "Content-Type"]
  config.keep_source_order = true
end

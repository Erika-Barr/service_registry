require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:json, :combined_text, :html]
  config.curl_host = 'http://localhost:3000'
  config.api_name = "Service Registry API"
  config.api_explanation = "Get information and perform actions on services"
  config.request_headers_to_include = ["Host", "Content-Type"]
  config.response_headers_to_include = ["Host", "Content-Type"]
end


require 'acceptance_helper'

resource "Service Registry", type: :request do
  header "Accept", "application/json"
  header "Content-Type", "application/json"
  before(:each) { FactoryBot.create(:service_registry) }
  get '/api/service_registries' do
    example_request 'Return all services' do
      explanation 'Return all services in service registry'
      expect(status).to eq(200)
      id = response["data"].first["id"]
      size = response["data"].size
      expect(response.to_json).to eq(response_for(:all_services).to_json)
    end
  end
  post '/api/service_registries' do
    parameter :service, 'name of service', required: true
    parameter :version, 'version number of service', required: true
    response_field :service, 'name of service'
    response_field :version, 'version number of service'
    response_field :status, "service status"
    let(:service) { "test"}
    let(:version) { "1.0.0"}
    let(:raw_post) { params.to_json }
    example_request 'Create a service' do
      explanation 'Create a service in service registry'
      id       = response["data"]["id"]
      expect(response.to_json).to eq(response_for(:creating_service).to_json)
    end
  end
  get '/api/service_registries/with_version' do
    parameter :service, 'name of service', required: true
    parameter :version, 'version number of service', required: true
    response_field :service, 'name of service'
    response_field :version, 'version number of service'
    response_field :count, "number of service instances"
    let(:service) { "test"}
    let(:version) { "1.0.0"}
    example_request 'search for a service with a specific version' do
      explanation 'returns number of service instances for a given version'
      expect(response.to_json).to eq(response_for(:searching_with_version).to_json)
    end
  end
  get '/api/service_registries/without_version' do
    parameter :service, 'name of service', required: true
    response_field :service, 'name of service'
    response_field :count, "number of service instances"
    let(:service) { "test"}
    let(:raw_post) { params.to_json }
    example_request 'search for a service without a specific version' do
      explanation 'returns number of service instances for a given service type'
      expect(response.to_json).to eq(response_for(:searching_without_version).to_json)
    end
  end
  #add an action to handle non existent service from the with_version action
#=begin
  get '/api/service_registries/with_version' do
    parameter :service, 'name of service', required: true
    parameter :version, 'version number of service', required: true
    response_field :service, 'name of service'
    response_field :version, 'version number of service'
    response_field :count, "number of service instances"
    let(:service) { "test"}
    let(:version) { "9.0.0"}
    example_request 'search for a service that does not exist' do
      explanation 'returns number of service instances for a given version'
      #byebug
      expect(response.to_json).to eq(response_for(:nonexistent_service).to_json)
    end
  end
#=end
  put '/api/service_registries/:id' do
    parameter :id, 'id of service', required: true
    parameter :service, 'data to update service'
    response_field :service, 'name of service'
    response_field :version, 'version number of service'
    response_field :status, "service status"
    let(:id) { 1 }
    let(:service) { "test_updated"}
    let(:raw_post) { params.to_json }
    example_request 'update a service' do
      explanation 'update a service instance in the registry'
      expect(response.to_json).to eq(response_for(:updating_service).to_json)
    end
  end
  delete '/api/service_registries/:id' do
    parameter :id, 'id of service', required: true
    response_field :service, 'name of service'
    response_field :status, "service status"
    let(:id) { 1 }
    let(:raw_post) { params.to_json }
    example_request 'remove a service' do
      explanation 'returns status for removed service'
      expect(response.to_json).to eq(response_for(:deleting_service).to_json)
    end
  end
end
#get '/api/v1/service-registry' #list all services
#post '/api/v1/service-registry #create service
#put '/api/v1/service-registry/:id' #update service
#delete '/api/v1/service-registry/:id' #delete service
#get '/api/v1/service-registry/with-version'
#get '/api/v1/service-registry/without-version'
=begin
  route url -> /api/v1/
  endpoints:
            ->  /service-registry
            ->  /service-registry/with-version
            ->  /service-registry/without-version
  methods:
            -> GET PUT POST DELETE
=end

require 'acceptance_helper'

resource "Service Registry" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"
  # do I need constraints
  get '/api/service_registries' do
    2.times { |n| let("service#{n}".to_sym) { FactoryBot.create(:service_registry) } }
    example_request 'Return all services' do
      explanation 'Return all services in service registry'
      expect(status).to eq(200)
      expect(response_body).to eq(ServiceRegistry.all.to_json)
    end
  end
  post '/api/service_registries' do
    with_options scope: :service_registry, required: true do
      parameter :service, 'name of service'
      parameter :version, 'version number of service'
    end
    with_options scope: :service_registry do
      response_field :service, 'name of service'
      response_field :version, 'version number of service'
      response_field :status, "service status"
    end
    let(:service) { "test1"}
    let(:version) { "1.0.0"}
    let(:raw_post) { params.to_json }
    example_request 'Create a service' do
      explanation 'Create a service in service registry'
      response = JSON.parse(response_body)
      #expect(ServiceRegistry.exists?(response["id"])).to eq(true)
      expect(response.to_json).to eq({"status": 201,
                                      "message": "successfully created service",
                                      "data": {
                                         "service": "test1",
                                         "version": "1.0.0",
                                         "status":  "created"
                                       }
                                     }.to_json)
    end
  end
  #with-version option -> implicity know from parameters sent in request
  get '/api/service_registries/with_version' do
    with_options scope: :service_registry, required: true do
      parameter :service, 'name of service'
      parameter :version, 'version number of service'
    end
    with_options scope: :service_registry do
      response_field :service, 'name of service'
      response_field :version, 'version number of service'
      response_field :count, "number of service instances"
    end
    2.times { |n| let("service#{n}".to_sym) { FactoryBot.create(:service_registry) } }
    let(:service) { "test1"}
    let(:version) { "1.0.0"}
    example_request 'search for a service with a specific version' do
      explanation 'returns number of service instances for a given version'
        response = JSON.parse(response_body)
        expect(response.to_json).to eq({ "status": 200,
                                         "message": "list of service records for requested version",
                                         "data": {
                                           "service": "test1",
                                           "version": "1.0.0",
                                           "count": 2
                                          }
                                        }.to_json)
    end
  end
  get '/api/service_registries/without_version' do
    with_options scope: :service_registry, required: true do
      parameter :service, 'name of service'
    end
    with_options scope: :service_registry do
      response_field :service, 'name of service'
      response_field :count, "number of service instances"
    end
    2.times { |n| let("service#{n}".to_sym) { FactoryBot.create(:service_registry) } }
    let(:service) { "test1"}
    let(:raw_post) { params.to_json }
    example_request 'search for a service WITHOUT a specific version' do
      explanation 'returns number of service instances for a given service type'
        response = JSON.parse(response_body)
        expect(response.to_json).to eq({ "status": 200,
                                         "message": "list of service records for requested version",
                                         "data": {
                                           "service": "test1",
                                           "count": 2
                                         }
                                        }.to_json)
    end
  end
  get '/api/service_registries/with_version' do
    with_options scope: :service_registry, required: true do
      parameter :service, 'name of service'
      parameter :version, 'version number of service'
    end
    with_options scope: :service_registry do
      response_field :service, 'name of service'
      response_field :version, 'version number of service'
      response_field :count, "number of service instances"
    end
    2.times { |n| let("service#{n}".to_sym) { FactoryBot.create(:service_registry) } }
    let(:service) { "test1"}
    let(:version) { "9.0.0"}
    let(:raw_post) { params.to_json }
    example_request 'search for a service that does not exist' do
      explanation 'returns number of service instances for a given version'
        response = JSON.parse(response_body)
        expect(response.to_json).to eq({ "status": 404,
                                         "message": "cannot find service records for requested version",
                                         "data": {
                                           "service": "test1",
                                           "version": "9.0.0",
                                           "status": "not_a_service"}
                                       }.to_json)
    end
  end
  put '/api/service_registries/:id' do
    with_options scope: :service_registry, required: true do
      parameter :id, 'id of service'
      parameter :data, 'data to update service'
    end
    with_options scope: :service_registry do
      response_field :service, 'name of service'
      response_field :version, 'version number of service'
      response_field :status, "service status"
    end
    2.times { |n| let("service#{n+1}".to_sym) { FactoryBot.create(:service_registry) } }
    let(:id) { service1.id }
    let(:data) { "test_updated"}
    let(:raw_post) { params.to_json }
    example_request 'update a service' do
      explanation 'update a service instance in the registry'
        response = JSON.parse(response_body)
        expect(response.to_json).to eq({ "status": 204,
                                         "message": "successfully updated service record",
                                         "data": {
                                           "service": "test_updated",
                                           "version": "1.0.0",
                                           "status": "updated" }
                                       }.to_json)
    end
  end
  delete '/api/service_registries/:id' do
    with_options scope: :service_registry, required: true do
      parameter :id, 'id of service'
    end
    with_options scope: :service_registry do
      response_field :service, 'name of service'
      response_field :status, "service status"
    end
    2.times { |n| let("service#{n+1}".to_sym) { FactoryBot.create(:service_registry) } }
    let(:id) { service1.id }
    let(:raw_post) { params.to_json }
    example_request 'remove a service' do
      explanation 'returns status for removed service'
        response = JSON.parse(response_body)
        expect(response.to_json).to eq({ "status": 204,
                                         "message": "successfully removed service",
                                         "data": {
                                           "status": "removed"
                                          }
                                        }.to_json)
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

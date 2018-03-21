module Api
  module V1
    class ServiceRegistriesController < ApplicationController
      #before_action :authenticate_api_user!, except: [:index, :with_version, :without_version]
      def create
        @service = ServiceRegistry.new(registry_params)
        if @service.save
          @service.created!
          options = {}
          options[:meta] = { message: 'successfully created service' }
          render json: ServiceRegistrySerializer.new(@service, options).serialized_json
        end
      end
      def index
        @services = ServiceRegistry.all
        options = {}
        options[:meta] = [{ message: 'All services in service registry' }, { service_instance_count: @services.count }]
        render json: ServiceRegistrySerializer.new(@services, options).serialized_json
      end
      def with_version
         @services = ServiceRegistry.all.service_with_version(registry_params[:service], registry_params[:version])
         if @services.empty?
           @service = ServiceRegistry.new(service: registry_params[:service], version: registry_params[:version])
           options = {}
           options[:meta] = [{ message: "cannot find service records for requested version" }, { service_instance_count: 0  }]
           render json: ServiceRegistrySerializer.new(@service, options).serialized_json
           return
         end
         options = {}
         options[:meta] = [{ message: 'list of services with specific version' }, { service_instance_count: @services.count }]
         render json: ServiceRegistrySerializer.new(@services, options).serialized_json
      end
      def without_version
         @services = ServiceRegistry.all.service_without_version(registry_params[:service])
         options = {}
         options[:meta] = [{ message: "list of services of type: #{registry_params[:service]}" }, { service_instance_count: @services.count }]
         render json: ServiceRegistrySerializer.new(@services, options).serialized_json
      end
      def update
        @service = ServiceRegistry.find(params[:id])
        if @service.update(service: registry_params[:service])
          @service.updated!
          options = {}
          options[:meta] = { message: 'successfully updated service' }
          render json: ServiceRegistrySerializer.new(@service, options).serialized_json
        end
      end
      def destroy
        @service = ServiceRegistry.find(params[:id])
        @service.removed!
        options = {}
        options[:meta] = { message: "successfully removed service" }
        render json: ServiceRegistrySerializer.new(@service, options).serialized_json
        @service.destroy!
      end

      private

      def registry_params
        params.permit(:service, :version)
      end
    end
  end
end

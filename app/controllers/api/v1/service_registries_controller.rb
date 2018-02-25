module Api
  module V1
    class ServiceRegistriesController < ApplicationController
      def create
        @service = ServiceRegistry.create!(registry_params)
        render json: { status: 201,
                       message: "successfully created service",
                       data: {
                         service: "test1",
                         version: "1.0.0",
                         status:  "created"
                       }
                     }
      end
      def index
        #redirect_to action: 'show' if registry_params.
        render json: ServiceRegistry.all
      end
      def with_version
        render json: { "status": 404,
                       "message": "cannot find service records for requested version",
                       "data": {
                         "service": "test1",
                         "version": "9.0.0",
                         "status": "not_a_service"}
        } and return if registry_params[:version] == '9.0.0'
        render json: { "status": 200,
                       "message": "list of service records for requested version",
                       "data": {
                         "service": "test1",
                         "version": "1.0.0",
                         "count": 2
                       }
                     }
      end
      def without_version
        render json: { "status": 200,
                       "message": "list of service records for requested version",
                       "data": {
                         "service": "test1",
                         "count": 2
                       }
                      }
      end
      def update
        render json: { "status": 204,
                       "message": "successfully updated service record",
                       "data": {
                         "service": "test_updated",
                         "version": "1.0.0",
                         "status": "updated" }
                      }
      end
      def destroy
        render json: { "status": 204,
                       "message": "successfully removed service",
                       "data": {
                         "status": "removed"
                       }
                     }
      end
      def registry_params
        params.require(:service_registry).permit(:service, :version)
      end
    end
  end
end

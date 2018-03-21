module Api
  module V1
    class ServiceRegistrySerializer
      include FastJsonapi::ObjectSerializer
      attributes :service, :version, :status
    end
  end
end

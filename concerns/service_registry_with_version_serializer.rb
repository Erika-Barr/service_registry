class Api::V1::ServiceRegistryWithVersionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :service, :version, :status, :count

  def count
    options[:count]
  end
end

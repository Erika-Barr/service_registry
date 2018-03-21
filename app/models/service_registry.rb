class ServiceRegistry < ApplicationRecord
  enum status: %i[ not_a_service created updated removed ]
  scope :service_with_version, -> (service=nil,version=nil) { where( service: service, version: version)}
  scope :service_without_version, -> (service=nil) { where( service: service)}
end

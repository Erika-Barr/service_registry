FactoryBot.define do
  factory :service_registry do
    service "test_service1"
    version "1.0.0"
    status :not_a_service
  end
end

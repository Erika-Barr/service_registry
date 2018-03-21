FactoryBot.define do
  factory :service_registry do
    service "test"
    version "1.0.0"
    status :created
  end
end

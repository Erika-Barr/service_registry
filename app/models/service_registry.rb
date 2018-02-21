class ServiceRegistry < ApplicationRecord
  enum status: %i[ not_a_service created updated removed ]
end

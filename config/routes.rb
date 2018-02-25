Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    scope module: "v1" do
      get '/service_registries/with_version' => 'service_registries#with_version'#, as: 'with_version'
      get '/service_registries/without_version' => 'service_registries#without_version'#, as: 'with_version'
      resources :service_registries
    end
  end
end

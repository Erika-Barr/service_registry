Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    scope module: "v1" do
      get '/service_registries/with_version' => 'service_registries#with_version'
      get '/service_registries/without_version' => 'service_registries#without_version'
      #get '/service_registries/:service' => 'service_registries#without_version'
      resources :service_registries

      #mount_devise_token_auth_for 'User', at: 'auth'
      #as :user do
      #  # Define routes for User within this block.
      #end
    end
  end
end

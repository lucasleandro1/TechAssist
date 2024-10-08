Rails.application.routes.draw do


  namespace :api do
    namespace :v1 do
      devise_for :users
      resources :tickets do
        collection do
          get 'status/:status', to: 'tickets#status', as: :status
        end
      end
      resources :clients
      resources :mobile_devices
      root to: "home#index"
      get 'search_clients', to: 'clients#search', as: 'search_clients'
    end
  end
end



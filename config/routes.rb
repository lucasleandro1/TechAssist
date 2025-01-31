Rails.application.routes.draw do
root to: 'api/v1/home#index'

  namespace :api do
    namespace :v1 do
      devise_for :users
      resources :tickets do
        collection do
          get 'status/:status', to: 'tickets#status', as: :status
          get :received
        end
        member do
          get 'generate_pdf'
        end
      end
      resources :clients
      resources :mobile_devices
      get 'search_clients', to: 'clients#search', as: 'search_clients'
      get 'search_mobile_devices', to: 'mobile_devices#search', as: 'search_mobile_devices'
    end
  end
end



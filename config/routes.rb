Rails.application.routes.draw do
  resources :tickets
  resources :clients
  resources :mobile_devices
  get 'search_clients', to: 'clients#search', as: 'search_clients'
  get 'search_devices', to: 'mobile_devices#search', as: 'search_mobile_device'
  resources :tickets do
    collection do
      get 'status/:status', to: 'tickets#status', as: :status
    end
  end
  
  devise_for :users
  root to: "home#index"
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  # Web routes - Manual routes first to avoid conflicts
  get '/tickets/new', to: 'tickets#new', as: 'new_ticket'
  get '/tickets/:id/edit', to: 'tickets#edit', as: 'edit_ticket'
  get '/clients/new', to: 'clients#new', as: 'new_client'
  get '/clients/:id/edit', to: 'clients#edit', as: 'edit_client'
  get '/mobile_devices/new', to: 'mobile_devices#new', as: 'new_mobile_device'
  get '/mobile_devices/:id/edit', to: 'mobile_devices#edit', as: 'edit_mobile_device'
  
  resources :tickets do
    collection do
      get 'status/:status', to: 'tickets#status', as: :status
    end
  end
  
  resources :clients do
    collection do
      get :search, as: :search_clients
    end
  end
  
  resources :mobile_devices do
    collection do
      get :search, as: :search_mobile_devices
      get 'select_or_create/:client_id', to: 'mobile_devices#select_or_create', as: :select_or_create
      post 'use_existing/:mobile_device_id', to: 'mobile_devices#use_existing', as: :use_existing
    end
  end

  # API routes
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



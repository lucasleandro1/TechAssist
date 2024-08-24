Rails.application.routes.draw do
  resources :tickets
  resources :clients
  resources :mobile_devices
  devise_for :users
  root to: "home#index"
end

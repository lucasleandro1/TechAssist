Rails.application.routes.draw do
  resources :registros
  devise_for :users
  root to: "home#index"
end

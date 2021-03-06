Rails.application.routes.draw do
  get 'notifications/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'

  post "incidents/:id/call", to: "twilio#call", as: "call_incident"
  post "connect/:phone_number", to: "twilio#connect"

  resources :incidents, only: %i[new create edit update show] do
    resources :messages, only: %i[new create]
  end
  resources :spaces
  resources :users, only: %i[show edit update]
  resources :notifications, only: %i[index show]
  get "profile", to: "users#profile", as: "profile"
end

Rails.application.routes.draw do
  get 'notifications/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'

  resources :incidents, only: %i[new create edit update show] do
    resources :messages, only: %i[new create]
  end
  resources :spaces
  resources :users, only: %i[show edit update]
  resources :notifications, only: %i[index show]
end

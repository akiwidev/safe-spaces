Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'

  resources :incidents, only: %i[new create update show] do
    resources :messages, only: %i[new create]
  end
  resources :spaces
  resources :users, only: %i[show edit update]
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :incidents, only: %i[create update show] do
    resources :messages, only: %i[new create]
  end
  resources :spaces
end

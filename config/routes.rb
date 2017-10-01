Rails.application.routes.draw do
  resources :members
  resources :users
  resources :teams
  resources :notifications
  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  get "/auth/:provider/callback", to: 'sessions#create'
  root to: 'pages#index'
end

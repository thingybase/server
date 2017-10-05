Rails.application.routes.draw do
  resources :members
  resources :users
  resources :teams
  resources :notifications

  resources :acknowledgements
  post "/twilio/acknowledgements", to: 'twilio_acknowledgements#create', as: :twilio_acknowledgement

  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  get "/auth/:provider/callback", to: 'sessions#create'

  root to: 'pages#index'
end

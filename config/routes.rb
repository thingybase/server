Rails.application.routes.draw do
  resources :phone_number_verifications,
    only: %w[edit update]
  resources :phone_number_claims,
    only: %w[index new create show destroy]
  resources :team_invitations
  resources :team_invitation_responses,
    only: %w[edit update]
  resources :members
  resources :users
  resources :teams
  resources :notifications

  resources :acknowledgements
  # TODO: Make this a POST and switch off TwiML
  get "/twilio/acknowledgements", to: 'twilio_acknowledgements#create', as: :twilio_acknowledgement

  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  get "/auth/:provider/callback", to: 'sessions#create'

  root to: 'pages#index'
end

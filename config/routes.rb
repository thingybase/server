def parent_resources(name, **opts)
  resources name, **opts do
    scope module: name do
      yield
    end
  end
end

def shallow
  defaults only: %i[index new] do
    yield
  end
end

Rails.application.routes.draw do
  resources :acknowledgements
  resources :members
  parent_resources :notifications do
    # Should I allow multiple-acks? I don't see why not.
    # TODO: Cover shallow controllers like this; or not. I'm
    # not sure if I need this.
    shallow do
      resources :acknowledgements
    end
  end
  parent_resources :phone_number_claims do
    # No ID ; should this really be an
    # `interaction` resource? e.g.
    # `interaction :acknowledgements`
    resource :verification
  end
  parent_resources :teams do
    resources :notifications
    resources :members
    resources :invitations
  end
  parent_resources :invitations do
    # No ID ; should this really be an
    # `interaction` resource? e.g.
    # `interaction :acknowledgements`
    resource :response
  end
  resources :users
  resources :api_keys, except: %i[edit update]

  # TODO: Make this a POST and switch off TwiML
  get "/twilio/acknowledgements", to: 'twilio_acknowledgements#create', as: :twilio_acknowledgement

  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  get "/auth/:provider/callback", to: 'sessions#create'

  root to: 'pages#index'
end

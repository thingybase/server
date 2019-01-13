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
  resources :members
  resources :labels
  parent_resources :phone_number_claims do
    # No ID ; should this really be an
    # `interaction` resource? e.g.
    # `interaction :acknowledgements`
    resource :verification
  end
  resources :accounts do
    resources :members
    resources :invitations
    resources :labels
  end
  resources :invitations do
    scope module: :invitations do
      # No ID ; should this really be an
      # `interaction` resource? e.g.
      # `interaction :acknowledgements`
      resource :response
    end
    member do
      put :email
    end
  end
  resources :users
  resources :api_keys, except: %i[edit update]

  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  get "/auth/:provider/callback", to: 'sessions#create'

  root to: 'pages#index'
end

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
  resources :containers do
    scope module: :containers do
      resources :children, only: %i[index new]
      resources :items, only: %i[new]
    end
  end
  resources :items
  resources :members
  resources :labels do
    scope module: :labels do
      resources :items, only: %i[create]
      resources :containers, only: %i[create]
    end
  end
  parent_resources :phone_number_claims do
    # No ID ; should this really be an
    # `interaction` resource? e.g.
    # `interaction :acknowledgements`
    resource :verification
  end
  resources :accounts do
    scope module: :accounts do
      resources :members
      resources :invitations
      resources :labels
      resources :items
      resources :containers
    end
    collection do
      get :launch
    end
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

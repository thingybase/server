def batch_resources(resources_name, **kwargs)
  resources resources_name,
    param: :ids,
    ids: /(\w+,)+\w+/,
    controller: "#{resources_name}/batches",
    as: "#{resources_name}_batch",
    **kwargs
end

def template_resources(*templates)
  namespace :templates do
    templates.each do |template|
      resource template, only: %i[new create], controller: "/items/templates/#{template}"
    end
  end
end

Rails.application.routes.draw do
  with_options to: "labels#scan", uuid: /[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}/i do |legacy_scan|
    # Labels printed before June 20, 2020 point to this route. When you decide to use `uuid` as the resource
    # key, instead of `id`, you will create a conflict where this route should redirect to the item for older
    # labels. Those older users would have to have a `/labels/:guid/show` link so they don't get redirected
    # when they want to edit to label.
    legacy_scan.get 'labels/:uuid'
    # Labels printer after June 20, 2020 get this link to avoid the conflict stated above.
    legacy_scan.get 'labels/:uuid/scan'
  end

  resources :items do
    get :search, to: "items/searches#index"
    scope module: :items do
      resources :children, only: %i[index new] do
        collection do
          get :templates
        end
      end
      resources :labels, only: %i[create]
      resources :copies, only: %i[create new]
      resources :batches, only: %i[new create]
      resource :icon, only: %i[edit update]
      resource :badge, only: :show
      template_resources :containers, :items, :perishables
    end
  end
  resources :members

  batch_resources :labels, only: :show
  resources :labels do
    member do
      get :scan
    end
    scope module: :labels do
      resources :items, only: %i[create]
    end
  end

  resources :phone_number_claims do
    scope module: :phone_number_claims do
      # No ID ; should this really be an
      # `interaction` resource? e.g.
      # `interaction :acknowledgements`
      resource :verification
    end
  end

  resources :accounts do
    get :search, to: "accounts/searches#index"
    scope module: :accounts do
      resources :members
      resources :member_requests, only: [:new, :create]
      resources :invitations
      resources :labels
      resources :items do
        collection do
          get :templates
        end
      end
      namespace :items do
        resources :batches, only: %i[new create]
      end
      resources :people, only: %i[index new], format: :html
      template_resources :containers, :items, :perishables, :rooms
    end
  end
  namespace :accounts do
    namespace :templates do
      resource :home
      resource :office
      resource :blank
    end
  end

  resources :member_requests, only: :show do
    scope module: :member_requests do
      resource :review, only: [:new, :create]
    end
  end

  resource :launch

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

  resources :icons do
    member do
      get :light
      get :dark
    end
  end

  resources :users
  resource :user_resolution, only: %i[create new]
  resource :email_code_verification, only: %i[create new]
  resource :signup, only: %i[create new]
  resources :api_keys, except: %i[edit update]

  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  get "/auth/:provider/callback", to: 'sessions#create'

  root to: 'pages#index'
end

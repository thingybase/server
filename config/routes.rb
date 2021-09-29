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
  with_options to: "labels#scan", uuid: UuidField::GUID_REGEXP do |legacy_scan|
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
      resources :children, only: %i[index new create] do
        collection do
          get :templates
        end
      end
      resources :ancestors, only: %i[index]
      resources :labels, only: %i[create]
      resources :copies, only: %i[create new]
      resources :batches, only: %i[new create]
      resource :icon, only: %i[edit update]
      resource :badge, only: :show
      resource :movement, only: %i[new create]
      resource :loanable, only: %i[new create], controller: "loanable_items"
      template_resources :containers, :items, :perishables
    end
  end

  resources :loanable_items

  resources :members

  resources :moves, only: %i[show edit destroy update] do
    scope module: :moves do
      resources :movements, only: %i[index new create]
      resource :movement_builder, only: %i[new create]
    end
  end

  resources :movements, only: %i[edit show update destroy] do
    scope module: :movements do
      resource :scan, only: :show
    end
  end

  batch_resources :labels, only: :show
  resources :labels, only: :show do
    member do
      get :scan
    end
    resource :standard, controller: "labels/standard"
    resource :jumbo, controller: "labels/jumbo"
    resource :code, controller: "labels/code"
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
      resource :loanable_list, only: [:new, :create, :show]
      resources :member_requests, only: [:new, :create]
      resources :invitations
      resource :move, only: [:new, :create, :show]
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

  resource :launch do
    get :profile
    get :account
    get :items
    get :people
    get :move
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

  resources :icons, only: :index

  resources :loanable_lists, only: %i[show edit destroy update] do
    scope module: :loanable_lists do
      resources :items, only: %i[index new create], controller: "loanable_items"
      resources :members, only: %i[index new create], controller: "loanable_list_members"
      resources :member_request, only: %i[index new create], controller: "loanable_list_member_requests"
      # resource :items_builder, only: %i[new create], controller: "loanable_items"
    end
  end

  resources :loanable_list_member_requests, only: :show do
    scope module: :loanable_list_member_requests do
      resource :review, only: [:new, :create]
    end
  end

  get "/vectors/hsl-:h,:s,:l/*id", to: "vectors#hsl",
    as: :vector,
    defaults: { h: 0, s: 0, l: 0, format: :svg }

  resources :users
  resource :user_resolution, only: %i[create new]
  resource :email_code_verification, only: %i[create new]
  resource :signup, only: %i[create new]
  resources :api_keys, except: %i[edit update]

  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  get "/auth/:provider/callback", to: 'sessions#create'

  get "*resource_path", to: "pages#show", format: false, constraints: Sitepress::RouteConstraint.new
  root to: "pages#show"

  # Rick-roll security scanners and script kiddies.
  get "/wp-login.php", to: redirect("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
end

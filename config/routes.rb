def batch_resources(resources_name, **kwargs)
  resources resources_name,
    param: :ids,
    ids: /(\w+,)+\w+/,
    controller: "#{resources_name}/batches",
    as: "#{resources_name}_batch",
    **kwargs
end

Rails.application.routes.draw do
  # Analytics
  constraints subdomain: "blazer" do
    mount Blazer::Engine, at: "/"
  end

  resource :email_authentication
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
    nest :children do
      collection do
        get :templates
      end
    end
    nest do
      list :ancestors
      create :labels
      create :copies
      create :batches
      create :movement
      create :loanable, controller: "loanable_items"
      edit :icon
      namespace :templates do
        create :container, :item, :perishable
      end
    end
  end

  resources :loanable_items

  resources :members

  resources :moves, only: %i[show edit destroy update] do
    nest :movements
    nest do
      create :movement_builder
    end
  end

  resources :movements, only: %i[edit show update destroy] do
    nest do
      show :scan
    end
  end

  batch_resources :labels, only: :show
  resources :labels, only: :show do
    member do
      get :scan
    end
    nest do
      resource :standard
      resource :jumbo
      resource :code
    end
  end

  resources :phone_number_claims do
    nest :verification
  end

  resources :accounts do
    get :search, to: "accounts/searches#index"
    nest :payment
    nest :move
    nest :members
    nest :invitations
    nest :items do
      collection do
        get :templates
      end
    end
    nest do
      resources :people, only: %i[index new]
      create :loanable_list
      create :member_requests
      namespace :items do
        create :batches
        namespace :templates do
          create :containers, :items, :perishables, :rooms
        end
      end
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
    nest do
      create :review
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
    nest :response
    member do
      put :email
    end
  end

  list :icons

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

  namespace :webhooks do
    resource :stripe_webhook, only: :create
  end

  get "/vectors/hsl-:h,:s,:l/*id", to: "vectors#hsl",
    as: :vector,
    defaults: { h: 0, s: 0, l: 0, format: :svg }

  resources :users
  create :signup
  resources :api_keys, except: %i[edit update]

  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  get "/auth/:provider/callback", to: 'sessions#create'

  sitepress_pages controller: :pages, root: true

  # Rick-roll security scanners and script kiddies.
  get "/wp-login.php", to: redirect("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
end

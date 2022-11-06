def is_singular_resource_name?(name)
  name_string = name.to_s
  name_string.singularize == name_string
end

def resource_plurality(name)
  is_singular_resource_name?(name) ? :resource : :resources
end

def inflect_resource_plurality(name, *args, **kwargs, &)
  self.method(resource_plurality(name)).call(name, *args, **kwargs, &)
end

def create(name, *args, **kwargs, &)
  nest { inflect_resource_plurality name, *args, **kwargs, & }
end

def edit(name, *args, only: %i[edit update], **kwargs, &block)
  nest { inflect_resource_plurality name, *args, **kwargs, &block }
end

def show(name, *args, only: :show, **kwargs, &block)
  nest { inflect_resource_plurality name, *args, **kwargs, &block }
end

def destroy(name, *args, only: :destroy, **kwargs, &block)
  nest { inflect_resource_plurality name, *args, **kwargs, &block }
end

def list(name, *args, only: :index, **kwargs, &block)
  nest { inflect_resource_plurality name, *args, **kwargs, &block }
end

def nest(name = nil, *args, except: nil, **kwargs, &block)
  if name.nil?
    scope module: parent_resource.name, &block
  elsif is_singular_resource_name? name
    scope module: parent_resource.name do
      except ||= %i[index edit update destroy]
      resource name, *args, except: except, **kwargs, &block
    end
  else
    scope module: parent_resource.name do
      except ||= %i[show edit update destroy]
      resources name, *args, except: except, **kwargs, &block
    end
  end
end

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

def nested_namespace(*args, **kwargs, &block)
  nest do
    collection do
      namespace(*args, **kwargs, &block)
    end
  end
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
    list :ancestors
    create :labels
    create :copies
    create :batches
    create :movement
    create :loanable, controller: "loanable_items"
    edit :icon
    template_resources :containers, :items, :perishables
  end

  resources :loanable_items

  resources :members

  resources :moves, only: %i[show edit destroy update] do
    nest :movements
    create :movement_builder
  end

  resources :movements, only: %i[edit show update destroy] do
    show :scan
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
    create :people, format: :html
    create :loanable_list
    create :member_requests
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
      namespace :items do
        resources :batches, only: %i[new create]
      end
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
    create :review
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

  namespace :webhooks do
    resource :stripe, only: :create
  end

  get "/vectors/hsl-:h,:s,:l/*id", to: "vectors#hsl",
    as: :vector,
    defaults: { h: 0, s: 0, l: 0, format: :svg }

  resources :users
  resource :signup, only: %i[create new]
  resources :api_keys, except: %i[edit update]

  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  get "/auth/:provider/callback", to: 'sessions#create'

  sitepress_pages controller: :pages, root: true

  # Rick-roll security scanners and script kiddies.
  get "/wp-login.php", to: redirect("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
end

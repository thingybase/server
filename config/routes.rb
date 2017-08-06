Rails.application.routes.draw do
  resources :notifications
  resource :session
  post "/auth/:provider/callback", to: 'sessions#create'
  root to: redirect("/notifications")
end

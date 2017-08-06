Rails.application.routes.draw do
  resources :notifications
  post "/auth/:provider/callback", to: 'sessions#create'
  root to: redirect("/notifications")
end

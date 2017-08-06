Rails.application.routes.draw do
  post "/auth/:provider/callback", to: 'sessions#create'
  root to: redirect("/auth/developer")
end

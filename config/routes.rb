Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  post "/test-vonage-api", to: "home#test_vonage_api", as: :test_vonage_api

  get "/dashboard", to: "dashboard#show", as: :dashboard

  resources :users, only: [:new, :create]
  get "/users/token/:token", to: "users#token", as: :user_token
  post "/users/verify", to: "users#verify", as: :verify_user
  delete "/sign-out", to: "sessions#destroy", as: :sign_out
end

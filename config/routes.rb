Rails.application.routes.draw do
  root "todos#index"

  resources :todos
  resource :user, only: %i[create edit update destroy]
  resolve("User") { [:user] }
  resources :password_resets, only: %i[new create edit update]

  get "/login" => "user_sessions#new", as: :login
  get "/signup" => "users#new", as: :signup
  post "/login" => "user_sessions#create"
  post "/logout" => "user_sessions#destroy", as: :logout
end

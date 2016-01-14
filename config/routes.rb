Rails.application.routes.draw do
  resources :items, only: [:index, :show]
  resources :categories, only: [:show], param: :slug
  resources :users, only: [:index, :new, :create]
  resources :cart_items, only: [:create, :destroy, :update]
  resources :orders, only: [:index, :create, :show]

  get "/cart", to: "cart_items#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "users#show"

  root "home#index"
end

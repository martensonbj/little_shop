Rails.application.routes.draw do
  resources :items, only: [:index, :show]
  resources :categories, only: [:show], param: :slug
  resources :users, only: [:index, :new, :create]
  resources :cart_items, only: [:create]
  get "/cart", to: "cart_items#index"
  get "/login", to: "sessions#new"
  get "/dashboard", to: "users#show"
  # post "/login", to: "sessions#create"
  # delete "/logout", to: "sessions#{destroy}"

  root "home#index"
end

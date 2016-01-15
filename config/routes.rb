Rails.application.routes.draw do
  resources :items, only: [:index, :show]
  resources :categories, only: [:show, :index], param: :slug
  resources :cart_items, only: [:create, :destroy, :update]

  resources :users, only: [:new, :create, :show] do
    get "/cart", to: "cart_items#index"
    resources :orders, only: [:index, :create, :show]
  end

  namespace :admin do
    get "/dashboard", to: "users#show"
    resources :items, only: [:new, :create]
  end

  get "/artists", to: "artists#index"

  get "/cart", to: "cart_items#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "users#show"

  root "home#index"
end

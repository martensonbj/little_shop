Rails.application.routes.draw do
  resources :items, only: [:index, :show]
  resources :categories, only: [:show], param: :slug
  resources :users, only: [:index]
  resources :cart_items, only: [:create, :destroy, :update]

  get "/cart", to: "cart_items#index"
  # post "/cart", to: "cart_items#update"

  root "home#index"
end

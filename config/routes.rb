Rails.application.routes.draw do
  resources :items, only: [:index, :show]
  resources :categories, only: [:show], param: :slug
  resources :users, only: [:index]
  resources :cart_items, only: [:create, :destroy]

  get "/cart", to: "cart_items#index"

  root "home#index"
end

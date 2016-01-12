Rails.application.routes.draw do
  get 'home/index'

  resources :items, only: [:index]
  resources :categories, only: [:show], param: :slug
  resources :users, only: [:index]

  root 'home#index'
end

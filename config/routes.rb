Rails.application.routes.draw do
  resources :items, only: [:index]
  resources :categories, only: [:show], param: :slug
  resources :users, only: [:index]

  root 'users#index'
end

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :recipes
  resources :kitchens, only: [:create, :new, :show]
  resources :food_types, only: [:create, :new, :show]
  resources :preferences, only: [:create, :new, :show]
end

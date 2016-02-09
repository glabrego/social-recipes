Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :recipes, only: [:create, :new, :show]
  resources :kitchens, only: [:create, :new, :show]
  resources :foodtypes, only: [:create, :new, :show]
end

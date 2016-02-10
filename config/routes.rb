Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'home#index'
  resources :recipes do
    member do
      post 'favorite'
      delete 'favorite'
    end
  end
  resources :users, only: [:show]
  resources :kitchens, only: [:create, :new, :show]
  resources :food_types, only: [:create, :new, :show]
  resources :preferences, only: [:create, :new, :show]
end

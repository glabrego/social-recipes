Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :recipes, only: [:create, :new, :show]
end

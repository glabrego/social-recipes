Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  resources :recipes, only: [:create, :new, :show]
end

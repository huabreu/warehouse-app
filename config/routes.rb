Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only:     [:show, :new, :create]
  resources :suppliers,  only:     [:show, :new, :create, :index]
  resources :product_models, only: [:show, :new, :create, :index]
  resources :product_bundles, only: [:show, :new, :create, :index]
end

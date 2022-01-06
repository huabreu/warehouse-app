Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only:     [:show, :new, :create, :edit, :update]
  resources :suppliers,  only:     [:show, :new, :create, :index]
  resources :product_models, only: [:show, :new, :create, :index, :edit, :update]
  resources :product_bundles, only: [:show, :new, :create, :index]
  resources :product_categories, only: [:show, :new, :create, :index]
  get 'product_items/entry', to: 'product_items#new_entry'
  post 'product_items/entry', to: 'product_items#process_entry'
end

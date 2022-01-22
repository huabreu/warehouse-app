Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy] do
    post 'product_entry', on: :member
    get 'search', on: :collection
  end
  resources :suppliers,  only: [:show, :new, :create, :index]
  resources :product_models, only: [:show, :new, :create, :index, :edit, :update] do
    patch :activate, on: :member
    patch :disable, on: :member
  end
  resources :product_bundles, only: [:show, :new, :create, :index]
  resources :product_categories, only: [:show, :new, :create, :index]

  get 'product_items/entry', to: 'product_items#new_entry'
  post 'product_items/entry', to: 'product_items#process_entry'

  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      resources :warehouses, only: [:index, :show, :create]
      resources :suppliers, only: [:index, :show, :create]
      resources :product_models, only: [:index, :show, :create]
    end
  end  
end

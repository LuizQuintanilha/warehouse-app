Rails.application.routes.draw do
  root to: 'home#index'
  #get '/', to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :product_models, only: [:index, :show, :new, :create, :edit, :update]
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  # get '/', to: 'home#index'
  resources :warehouses, only: %i[show new create edit update destroy]
  resources :suppliers, only: %i[index show new create edit update destroy]

  # authenticate :user do
  resources :product_models, only: %i[index show new create]
  # end

  resources :orders, only: %i[new create show index edit update edit update] do
    resources :order_items, only: %i[new create]
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
  end
end

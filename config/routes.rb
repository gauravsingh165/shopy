Rails.application.routes.draw do
  get 'order/index'
  get 'order/new'
  get 'order/show'
  post 'order/update'
  get 'completion', to: 'completion#index'
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :products
  resources :shops
  resources :order_items
  resources :cards
  post '/checkout', to: 'checkout#create', as: 'checkout_create'
  resources :webhooks, only: [:create]

  root "shops#index"
end

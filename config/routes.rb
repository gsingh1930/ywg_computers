Rails.application.routes.draw do
  get "orders/index"
  get "orders/show"
  devise_for :users
  ActiveAdmin.routes(self)

  root "products#index"

  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :show ]

  # Cart routes
  get "cart", to: "cart#show"
  post "cart/add/:id", to: "cart#add", as: "add_to_cart"
  delete "cart/remove/:id", to: "cart#remove", as: "remove_from_cart"
  patch "cart/update/:id", to: "cart#update", as: "update_cart"

  # Checkout routes
  get "checkout", to: "checkout#index"
  post "checkout/process_order", to: "checkout#process_order", as: "process_order"

  # Orders
  resources :orders, only: [ :index, :show ]
end

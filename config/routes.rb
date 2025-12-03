Rails.application.routes.draw do
  get "pages/show"
  devise_for :users
  ActiveAdmin.routes(self)

  root "products#index"

  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :show ]

  # Cart routes (all GET for simplicity)
  get "cart", to: "cart#show"
  get "cart/add/:id", to: "cart#add", as: "add_to_cart"
  get "cart/remove/:id", to: "cart#remove", as: "remove_from_cart"
  patch "cart/update/:id", to: "cart#update", as: "update_cart"

  # Checkout routes
  get "checkout", to: "checkout#index"
  post "checkout/process_order", to: "checkout#process_order", as: "process_order"

  # Orders
  resources :orders, only: [ :index, :show ]

  get ":slug", to: "pages#show", as: "page", constraints: { slug: /about|contact/ }
end

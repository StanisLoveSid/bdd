Rails.application.routes.draw do
  get 'cart/show'
  get 'order_items/create'
  devise_for :users
  resources :users
  resources :orders
  root "page#home"
  resources :books do
    resources :reviews
  end
  resources :categories
  resources :checkouts
  get "/buy_book", to: "order_items#create", as: :buy_book
  delete "/remove_book/:id", to: "order_items#destroy", as: :remove_book
  get "/cart", to: "cart#show", as: :cart
end

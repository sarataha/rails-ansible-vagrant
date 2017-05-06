Rails.application.routes.draw do

  # redirect root to index of products
  # at index action of products controller the action checks if user is logged in
  # if user is logged in it will render the products page
  # if not it will redirect the user to the login page
  root "products#index"
  resources :products do
    resources :comments
  end
  
  resources :categories
  resources :cart_items
  resources :carts
  resources :administrator
  resources :about
  resources :users do
    resources :orders
  end

  get "login" => "sessions#new"
  get "admin" => "administrator#show", as: :dashboard
  get "admin/products" => "administrator#product_index", as: :admin_products
  get "admin/orders" => "administrator#order_index", as: :admin_orders
  get "admin/users" => "administrator#user_index", as: :admin_users
  get "admin/categories" => "administrator#category_index", as: :admin_categories

  post "login" => "sessions#create"
  post "checkout" => "checkout#create", as: :checkout
  post "/products/:product_id/comments(.:format)" => "comments#create", as: :create_product_comment

  patch "order_status" => "administrator#update", as: :order_status
  patch "/products/:product_id/edit_status" => "products#edit_status", as: :edit_status
  
  delete "logout" => "sessions#destroy"
  delete "carts/:item_id/", to: "carts#destroy", as: :cart_item_delete

end

Rails.application.routes.draw do

  # 以下、customer
  root 'public/homes#top'
  get '/about' => 'public/homes#about'

  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
  }

  scope module: :public do
    resource :customers
  end
  get '/customers/confirm' => 'public/customers#confirm', as: "confirm_customers"
  patch '/customers/withdraw' => 'public/customers#withdraw', as: "withdraw_customers"

  get '/items' => 'public/items#index'
  get '/item/:id' => 'public/items#show', as: "item"

  get '/cart_items' => 'public/cart_items#index'
  patch '/cart_items/:id' => 'public/cart_items#update', as: "edit_cart_items"
  delete '/cart_items/destroy_all' => 'public/cart_items#destroy_all', as: "destroy_all_cart_items"
  delete '/cart_items/:id' => 'public/cart_items#destroy', as: "destroy_cart_items"
  post '/cart_items' => 'public/cart_items#create'

  post '/orders/confirm' => 'public/orders#confirm', as: "confirm_orders"
  get '/orders/thanks' => 'public/orders#thanks', as: "thanks_orders"
  scope module: :public do
    resources :orders, only:[:new, :create, :index, :show] do
      resources :order_details, only:[:create, :destroy]
    end
  end

  scope module: :public do
    resources :addresses, only:[:index, :edit, :create, :update]
  end
  delete '/address/:id' => 'public/addresses#destroy', as: "destroy_address"

  # 以下、admin
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
  }

  # namespace :admin do
  #   resources :items, :customers
  # end

  namespace :admin do
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :orders, only:[:index, :show, :update]
    resources :order_details, only:[:update]
  end

  # namespace :admin do
  #   resources :genres, only:[:index, :create, :edit, :update]
  # end
  # namespace :admin do
  #   resources :orders, only:[:index, :show, :update]
  # end
  # namespace :admin do
  #   resources :order_details, only:[:update]
  # end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

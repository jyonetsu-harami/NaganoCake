Rails.application.routes.draw do
  get 'homes/top'
  get 'homes/about'
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'about' => 'homes#about'

  namespace :admin do
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
  end


  resources :products, only: [:index, :show]
  resources :cart_items, only: [:create, :index, :update, :destory] do
    member do
      delete :destory_all
    end
  end
  resources :orders, only: [:new, :create, :index, :show] do
    member do
      post :order_confirm
      get :order_success
    end
  end
  resources :customers, only: [:show, :edit, :update] do
    member do
      get :unsubscribe
      patch :withdraw
    end
  end
  resources :shipping_informations, only: [:index, :create, :edit, :update, :destory]
  
end

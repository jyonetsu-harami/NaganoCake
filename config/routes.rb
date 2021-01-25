Rails.application.routes.draw do
  get 'homes/top'
  get 'homes/about'
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  }

  root 'homes#top'
  get 'about' => 'homes#about'
  get 'admin/top' => 'homes#admin'
  
  namespace :admin do
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :update, :edit]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
  end


  resources :products, only: [:index, :show]
  resources :cart_items, only: [:create, :index, :update, :destroy] do
    collection do
      delete :destroy_all
    end
  end
  resources :orders, only: [:new, :create, :index, :show] do
    resources :order_items, only: [:create]
    collection do
      post :order_confirm
      get :order_success
    end
  end
  resource :customers, only: [:show, :edit, :update] do
    member do
      get :unsubscribe
      patch :withdraw
    end
  end
  resources :shipping_informations, only: [:index, :create, :edit, :update, :destroy]
# destoryからdestroyへ変更
end

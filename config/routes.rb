Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  root 'users#index'
  
  post '/users/guest_sign_in', to: 'users#guest_sign_in'
  
  post 'guest_login', to: 'sessions#guest_login'
  
  resources :users
  resources :vendors do
    resources :vendor_favorites, only: [:create, :destroy]
  end
  resources :user_notifications
  resources :vendor_favorites
  resources :events do
    resource :favorite, module: :events, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

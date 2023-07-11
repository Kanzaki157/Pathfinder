Rails.application.routes.draw do
    devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  root 'users#index'
  
  post '/users/guest_sign_in', to: 'users#guest_sign_in'
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
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

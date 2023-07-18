Rails.application.routes.draw do
  # 重複した devise_for :users を削除
  # sessions と registrations をまとめて指定
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  root 'users#index'
  
  # 下記の2行は上の devise_scope で既に定義しているので削除
  # post '/users/guest_sign_in', to: 'users#guest_sign_in'
  # post 'guest_login', to: 'sessions#guest_login'
  
  resources :users
  resources :vendors do
    resources :vendor_favorites, only: [:create, :destroy]
  end
  
  resources :user_notifications
  
  resources :vendor_favorites
  
  resources :events do
      collection do
        post :confirm
      end
    # 以下の行で、イベントの参加と退出に対応するルートを追加しています。
    # POST /events/:event_id/event_participants に対応するアクションは EventParticipantsController#create
    # DELETE /events/:event_id/event_participants/:id に対応するアクションは EventParticipantsController#destroy
    resources :event_participants, only: [:create, :destroy]
    resource :favorite, module: :events, only: [:create, :destroy]
    post 'join', on: :member
  end
end

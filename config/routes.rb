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
  
  get "test_page" => "users#test_page",as: "test_page"
  
  root 'users#index'
  namespace :admin do
    resources :users, only: [:index, :destroy] do
      member do
        put :toggle_active
      end
    end
  end
  # 下記の2行は上の devise_scope で既に定義しているので削除
  # post '/users/guest_sign_in', to: 'users#guest_sign_in'
  # post 'guest_login', to: 'sessions#guest_login'
  
  resources :users
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end
  
  resources :user_notifications
  
  resources :events do
      collection do
        post :confirm
      end
    # 以下の行で、イベントの参加と退出に対応するルートを追加しています。
    # POST /events/:event_id/event_participants に対応するアクションは EventParticipantsController#create
    # DELETE /events/:event_id/event_participants/:id に対応するアクションは EventParticipantsController#destroy
    resources :event_participants, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy], controller: 'event_favorites'
    
    post 'join', on: :member
    post 'cancel', on: :member
    delete 'remove_participant', on: :member
  end
end

Rails.application.routes.draw do
  get 'homepages/index'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'notifications/index'
  root to: "toppages#index"
  get "/login" ,to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :calendars, only: [:index]
  resources :participates, only: [:destroy, :create, :index]
  resources :favorites, only: [:destroy, :create]
  resources :plans
  resources :messages
  resources :members, only:[:create, :destroy, :update]
  resources :users do
    member do
      get :group
      get :favorites
      get :follow
      get :followers
      get :messages
      get :invited
    end 
  end
  resources :microposts
  resources :groups do
    member do
      get :member
      get :requests
      get :admin_member
      get :invited
      
    end 
  end
  resources :notifications, only: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :searches, only: [:index]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :edit, :create, :update]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/mail_confirm"
  end
end

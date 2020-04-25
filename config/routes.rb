Rails.application.routes.draw do

  get 'home/about', 'home#about'
  root  'home#top'
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end
 
  devise_for :users, skip: [:sessions],
  :controllers => {
    :registrations => 'users/registrations',
    :passwords => 'users/passwords',
    :omniauth_callbacks => 'users/omniauth_callbacks'
  }
   devise_scope :user do
    get 'users/sign_in' => 'users/sessions#new', as: 'new_user_session'
    post 'users/sign_in' => 'users/sessions#create', as: 'user_session'
    delete '/sign_out' => 'devise/sessions#destroy', as: 'destroy_user_session'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
 
  resources :users, only: [:edit,:show,:create,:update,:destroy,:index] do
    member do
      get :following, :followers
    end
    collection do
      get 'search'  
    end 
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す 
  
  resources :brands
  resources :chocolates do 
   collection do
    get 'search' 
   end
    resource :favorites, only: [:create, :destroy]  
    resource :comments, only: [:create, :destroy]
  end
  resources :comments, only: [:index]
  
  get 'favorites/destroy'
  
  resources :relationships, only: [:create, :destroy]

  namespace  :admin do
    resources :users
    resources :chocolates
    resources :brands
  end
end

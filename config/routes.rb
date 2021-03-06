Rails.application.routes.draw do
  get 'home/about', 'home#about'
  root 'home#top'
  get 'home/sorry', 'home#sorry'
  get 'home/health', 'home#health'
  get 'policy', to: 'home#policy'
  get 'privacypolicy', to: 'home#privacypolicy'
  get 'contact', to: 'contacts#new'
  post 'contacts', to: 'contacts#create'
  get 'contacts', to: 'contacts#index'

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
                       :omniauth_callbacks => 'users/omniauth_callbacks',
                     }
  devise_scope :user do
    get 'users/sign_in' => 'users/sessions#new', as: 'new_user_session'
    post 'users/sign_in' => 'users/sessions#create', as: 'user_session'
    delete '/sign_out' => 'devise/sessions#destroy', as: 'destroy_user_session'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: [:edit, :show, :create, :update, :destroy, :index] do
    member do
      get :following, :followers
      get :favorite_chocolates
    end
    collection do
      get 'search'
    end
  end
  get 'users/:id/follows' => 'users#follows', as: 'follows_users'
  get 'users/:id/followers' => 'users#followers', as: 'followers_users'
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

  resources :chocolates do
    collection do
      get 'search'
      get 'ranking'
      get 'favorite_ranking'
      get 'taste_ranking'
      get 'cost_performance_ranking'
      get 'healthy_ranking'
    end
    resource :favorites, only: [:create, :destroy]
  end

  resources :comments, only: [:create, :destroy, :index]

  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    resources :users
    resources :comments
  end

  get 'search' => 'searches#search'
  get 'search/user' => 'searches#user_search'
end

Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end
  get 'homes/about'
  resources :brands


  devise_for :users, skip: [:sessions],
  :controllers => {
    :registrations => 'users/registrations',
  } 
   devise_scope :user do
    get 'users/sign_in' => 'users/sessions#new', as: 'new_user_session'
    post 'users/sign_in' => 'users/sessions#create', as: 'user_session'
    get '/sign_out' => 'devise/sessions#destroy', as: 'destroy_user_session'
  end
  
  namespace  :admin do
    resources :users
    resources :chocolates
    resources :brands
  end

  get 'home/index'
  get 'home/show'

  root to: "chocolates#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :chocolates, only: [:new, :create, :index, :show]

end

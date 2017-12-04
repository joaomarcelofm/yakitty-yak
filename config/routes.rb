Rails.application.routes.draw do
  get 'requests/new'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", users: "users/users" }

  resources :users, only: [:show, :edit, :update]
  resources :requests, only: [:new, :create]

  root to: 'pages#home'

  get '/form', to: 'pages#form'
  get '/meetings', to: "pages#meetings"
  get '/dashboard', to: "pages#dashboard"

  resources :meetings, only: [:new, :show]

end

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", users: "users/users" }

  resources :users, only: [:show, :edit, :update]

  root to: 'pages#home'

  get '/form', to: 'pages#form'
  get '/meetings', to: "pages#meetings"

  resources :meetings do
    resources :meetings, only: [:new, :show]
  end

end

Rails.application.routes.draw do
  get 'requests/new'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", users: "users/users" }

  resources :users, only: [:show, :edit, :update]
  resources :requests, only: [:new, :create] do
    member do                             # member => restaurant id in URL
      get 'accept', to: "requests#accept"  # RequestsController#accept
      get 'reject', to: "requests#reject"  # RequestsController#accept
    end
  end

  root to: 'pages#home'

  post '/webhooks', to: 'hooks#push'

  get '/meetings', to: "pages#meetings"
  get '/dashboard', to: "pages#dashboard"
  get '/feed', to: "pages#feed"
  get '/calendar', to: "pages#calendar"
  get '/team-yaks', to: "pages#team_yaks"

  resources :meetings, only: [:new, :show]

  scope '/hooks', :controller => :hooks do
    post :push
  end

end

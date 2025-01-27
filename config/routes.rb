# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: [:show, :index]
      resources :videos, only: [:show]
    end
  end

  namespace :api do
    namespace :v1 do
      put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
    end
  end

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create, :new]
    end
    resources :videos, only: [:edit, :update, :destroy]
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: [:new, :create,]

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only: [:create]

  get 'auth/github', as: 'github_login'
  get 'auth/github/callback', to: 'github/sessions#create'
  post 'friendships/:id', to: 'friendships#create', as: :friendships

  get 'activate', to: 'activation#create', as: :email_activation
  get 'register/:code', to: 'register#create', as: :user_activation

  get '/invite', to: 'invite#new', as: :send_invitation
  post '/invite', to: 'invite#create', as: :invite
end

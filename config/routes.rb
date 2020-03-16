Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :microposts, only: [:new, :show, :create, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  
end

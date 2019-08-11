Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'password_reset/new'

  get 'password_reset/edit'

  root to: 'sessions#new'

  get '/register', to: 'users#new', as: 'register'
  post '/register', to: 'users#create'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users, except: [:show, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
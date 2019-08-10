Rails.application.routes.draw do
  root to: 'sessions#new'

  get '/register', to: 'users#new', as: 'register'
  post '/register', to: 'users#create'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :users, except: [:show, :destroy]
end
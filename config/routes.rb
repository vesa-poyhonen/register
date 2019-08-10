Rails.application.routes.draw do
  root to: 'users#new'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  resources :users, except: [:show, :destroy]
end
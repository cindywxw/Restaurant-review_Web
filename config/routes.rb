Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  # delete '/tables/:id' => 'tables#destroy'

  resources :restaurants
  resources :reservations
  resources :users
  resources :reviews
  resources :tables
  resources :stats

end

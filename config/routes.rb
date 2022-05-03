Rails.application.routes.draw do
  get 'trains/index'
  get 'trains/show'
  get 'trains/edit'
  devise_for :users
  resources :users, except: [:new, :create]
  resources :routes
  resources :stations, except: [:show] do
    patch 'update_station_connections'
  end
  resources :carriages, except: [:show]
  resources :trains


  get 'stations/search/:name', to: 'stations#search_stations', as: 'search_stations'
  get 'home/index'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path routes ("/")
  # root "articles#index"
end

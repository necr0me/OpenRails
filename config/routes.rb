Rails.application.routes.draw do
  devise_for :users
  resources :users, except: [:new, :create]
  resources :routes
  resources :stations do
    patch 'update_station_connections'
  end
  resources :carriages, except: [:edit]
  resources :trains
  resources :tickets, except: [:show, :new, :edit]


  get 'stations/search/:name', to: 'stations#search_stations', as: 'search_stations'
  get 'home/index'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path routes ("/")
  # root "articles#index"
end

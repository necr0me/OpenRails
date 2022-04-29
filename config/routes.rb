Rails.application.routes.draw do
  get 'route/index'
  get 'route/show'
  get 'route/new'
  get 'route/edit'
  devise_for :users
  resources :users, only: [:show, :edit, :update, :destroy, :index]
  resources :stations, only: [:new, :create, :edit, :update, :destroy, :index] do
    patch 'update_station_connections'
  end

  get 'stations/search/:name', to: 'stations#search_stations', as: 'search_stations'
  get 'home/index'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

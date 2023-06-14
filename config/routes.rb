Rails.application.routes.draw do
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      resources :forecast, only: %i[index]
      resources :users, only: %i[create]
      resources :sessions, only: %i[create]
      resources :road_trip, only: %i[create]
    end
  end
end

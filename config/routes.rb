Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'homepages#index'

  resources :drivers
  
  resources :passengers do
    resources :trips, only: [:create]
  end

  resources :trips, only: [:show, :edit, :update, :destroy]
  
  
  # get '/drivers', to: 'drivers#index', as: 'drivers'
  # get "/drivers/new", to: 'drivers#new', as: 'new_driver'

  # get '/drivers/:id', to: 'drivers#show', as: 'driver'
  # post '/drivers', to: "drivers#create"
  # get '/drivers/:id/edit', to: "drivers#edit", as: 'edit_driver'
  # patch '/drivers/:id', to: 'drivers#update'
  # delete '/drivers/:id', to: 'drivers#destroy'

  # get '/passengers', to: 'passengers#index', as: 'passengers'
  # get '/passengers/new', to: 'passengers#new', as: 'new_passenger'

  # get '/passengers/:id', to: 'passengers#show', as: 'passenger'
  # post '/passengers', to: 'passengers#create'
  # get '/passengers/:id/edit', to: 'passengers#edit', as: 'edit_passenger'
  # patch '/passengers/:id', to: 'passengers#update'
  # delete 'passengers/:id', to: 'passengers#destroy'
  
  
  # get '/trips', to: 'trips#index', as: 'trips' # TODO: Do we even need this route at all?
  # get '/trips/:id', to: 'trips#show', as: 'trip'
  # get '/trips/:id/edit', to: 'trips#edit', as: 'edit_trip'
  # patch '/trips/:id', to: 'trips#update'
  # delete '/trips/:id', to: 'trips#destroy'
  


end

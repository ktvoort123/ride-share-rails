Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/drivers', to: 'drivers#index', as: 'drivers'


  get '/passengers', to: 'passengers#index', as: 'passengers'


  get '/trips', to: 'trips#index', as: 'trips'
end

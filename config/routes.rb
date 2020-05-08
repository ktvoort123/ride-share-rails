Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get '/drivers', to: 'drivers#index', as: 'drivers'
  get "/drivers/new", to: 'drivers#new', as: 'new_driver'

  get '/drivers/:id', to: 'drivers#show', as: 'driver'
  post '/drivers', to: "drivers#create"
  get '/drivers/:id/edit', to: "drivers#edit", as: 'edit_driver'
  patch '/drivers/:id', to: 'drivers#update'
  delete '/drivers/:id', to: 'drivers#destroy'

  # get    "/books"          , to: "books#index",   as: :book
  # post   "/books"          , to: "books#create"
  # get    "/books/new"      , to: "books#new",     as: :new_book
  # get    "/books/:id"      , to: "books#show",    as: :book
  # patch  "/books/:id"      , to: "books#update"
  # put    "/books/:id"      , to: "books#update"
  # delete "/books/:id"      , to: "books#destroy"
  # get    "/books/:id/edit" , to: "books#edit",    as: :edit_book
  
  
  get '/passengers', to: 'passengers#index', as: 'passengers'
  
  
  get '/trips', to: 'trips#index', as: 'trips'
end

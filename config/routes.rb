Rails.application.routes.draw do
  root 'maneuvers#index'

  resources :maneuvers, only: %i(index show)

  get '/buses/:number/participants', to: 'buses#participants'
end

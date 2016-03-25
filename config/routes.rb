Rails.application.routes.draw do
  root 'maneuvers#index'

  resources :maneuvers, only: :index do
    member do
      get :next_participant
    end
  end

  resources :maneuver_participants, only: %i(create new)

  resources :participants, only: :index
end

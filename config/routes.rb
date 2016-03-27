Rails.application.routes.draw do
  root 'maneuvers#index'

  resources :circle_check_scores, only: %i(create index update)

  resources :maneuvers, only: :index do
    member do
      get :next_participant
      get :previous_participant
    end
  end

  resources :maneuver_participants, except: %i(destroy edit index)

  resources :participants, only: :index do
    collection do
      get :scoreboard
    end
  end

  resources :quiz_scores, only: %i(create index update)
end

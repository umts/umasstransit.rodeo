Rails.application.routes.draw do
  devise_for :users
  root 'maneuvers#index'

  resources :circle_check_scores, only: %i(create index update)

  resources :maneuvers, only: :index do
    member do
      get :next_participant
      get :previous_participant
    end
  end

  resources :maneuver_participants, except: %i(destroy edit index)

  resources :onboard_judgings, except: %i(destroy edit index) do
    collection do
      get :select_participant
    end
  end

  resources :participants, except: %i(edit new show) do
    collection do
      get :scoreboard
      get :scoreboard_partial
    end
  end

  resources :quiz_scores, only: %i(create index update)
end

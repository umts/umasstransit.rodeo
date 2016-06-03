Rails.application.routes.draw do
  devise_for :users

  root 'participants#welcome'

  get  'faye_test', to: 'faye#test', as: :faye_test
  post 'faye_test', to: 'faye#test'

  resources :buses, only: %i(create index destroy)

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
      post :assign_number
      get :scoreboard
      get :scoreboard_partial
      get :welcome
    end
  end

  resources :quiz_scores, only: %i(create index update)

  namespace :admin do 
    resources :users, only: %i(destroy index update)
  end

end

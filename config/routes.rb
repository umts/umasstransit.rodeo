Rails.application.routes.draw do
  devise_for :users
  as :user do
    get 'users/edit', to: 'devise/registrations#edit', as: :edit_user_registration
    put 'users', to: 'devise/registrations#update', as: :user_registration           
  end

  root 'participants#welcome'

  get  'faye_test', to: 'faye#test', as: :faye_test
  post 'faye_test', to: 'faye#test'

  resources :buses, only: :create, :destroy, :index

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
end

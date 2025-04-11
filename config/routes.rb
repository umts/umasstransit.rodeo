# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  devise_for :users

  root 'participants#welcome'

  resources :buses, only: %i[create index destroy]

  resources :circle_check_scores, only: %i[create index update]

  resources :maneuvers, only: :index do
    member do
      get :next_participant
      get :previous_participant
    end
  end

  resources :maneuver_participants, except: %i[destroy edit index]

  resources :onboard_judgings, except: %i[destroy edit index] do
    collection do
      get :select_participant
    end
  end

  resources :participants, except: %i[edit new show] do
    collection do
      post :assign_number
      get :scoreboard
      get :welcome
    end
  end

  resources :quiz_scores, only: %i[create index update]

  namespace :admin do
    resources :users, only: %i[destroy index update] do
      collection do
        get :manage
      end
      member do
        post :approve
      end
    end
  end

  post :toggle_scores_lock, to: 'settings#toggle_scores_lock'
  get '/manifest', to: 'rails/pwa#manifest', as: 'pwa_manifest'
end

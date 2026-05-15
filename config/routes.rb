# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: {
    registrations: 'users/registrations'
    # sessions: 'users/sessions'
  }

  devise_scope :user do
    post '/signup', to: 'users/registrations#create'
    # post "/signin", to: "users/sessions#create"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # @see AboutController
  root to: 'about#show', defaults: { format: 'json' }
  resources :genres, only: %i[index show]
  resources :books, only: %i[index show create update destroy]
  resources :users, only: %i[index show destroy update]
end

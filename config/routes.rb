# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper

  devise_for :users, skip: %i[sessions registrations]

  devise_scope :user do
    post '/signup', to: 'users/registrations#create', as: :signup
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # @see AboutController
  root to: 'about#show', defaults: { format: 'json' }
  resources :genres, only: %i[index show]
  resources :books, only: %i[index show create update destroy] do
    collection do
      get :user_books
    end
  end
  resources :users, only: %i[index show destroy update]
end

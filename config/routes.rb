# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :home, only: %i[index show destroy] do
    member do
      post 'follow'
    end
  end

  resources :posts, except: [:show], shallow: true do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[index create destroy]
  end

  resources :users, only: %i[index show new update] do
    collection do
      get 'search'
    end
    resources :requests, only: %i[index create destroy]
  end

  resources :approves, only: %i[index update destroy]
  resources :visibility, only: %i[index]
  resources :stories, only: %i[index new create destroy]
end

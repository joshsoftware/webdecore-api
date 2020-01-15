# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    root 'users/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :themes
  resources :dashboard
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

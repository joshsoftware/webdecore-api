# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :user do
    resources :themes
    root 'users/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users
  resources :dashboard
  resources :categories do
  	resources :animation_datas
  end
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

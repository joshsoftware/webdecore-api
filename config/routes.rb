# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    root 'users/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :themes
  resources :dashboard
  resources :categories
  resources :animation_datas

  scope "/categories/:id/" do
    get "sub_categories" => 'categories#show'

    scope "sub_categories/:sub_category_id/" do
      get "animations" => 'animation_datas#show'
    end
  end

  namespace :api do  
    namespace :v1 do
      resources :animation_datas
    end
  end

end

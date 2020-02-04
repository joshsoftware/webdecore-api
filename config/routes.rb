# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    root 'users/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :themes

  resources :dashboard

  resources :categories

  resources :animation_datas

  scope "/categories/:id/" do
    get "sub_categories" => 'categories#sub_categories'

    scope "sub_categories/:sub_category_id/" do
      get "animations" => 'animation_datas#show'
    end
  end

  # get '/categories/:id/sub_categories/:sub_category_id/animations/:animation_id/show' => "animations#show"



  namespace :api do  
    namespace :v1 do
      resources :animation_datas
    end
  end


  namespace :api do  
    namespace :v2 do
      resources :animation_datas
    end
  end





  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

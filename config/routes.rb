Rails.application.routes.draw do
  # default_url_options :host => "localhost:3000"
  devise_for :users ,controllers: {registrations: 'users/registrations', confirmations: "users/confirmations"}
  devise_scope :user do
    root 'users/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
    patch "users/confirm" => "users/confirmations#confirm"
  end

  resources :themes
  resources :dashboard
  resources :categories
  resources :animation_datas
  resources :user_animations, only: [:index,:create]

  get 'users_details' => 'dashboard#users_details'
  get 'order_details' => 'dashboard#order_details'
  scope "/categories/:id/" do
    get "sub_categories" => 'categories#show'
    get "new_sub_category" => 'categories#new_sub_category'
    post "new_sub_category" => 'categories#create_sub_category'

    scope "sub_categories/:sub_category_id/" do
      get "animations" => 'animation_datas#show'
      get "new_animation" => 'animation_datas#new'
      post "new_animation" => 'animation_datas#create'

        scope "animations/:animation_data_id" do
            get "purchase" => 'user_animations#new'
            get "demo" => 'animation_datas#demo'
        end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :animation_datas
      get '/animation_datas' , to: 'animation_datas#index'
    end
  end
end

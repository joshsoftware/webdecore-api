Rails.application.routes.draw do

  devise_for :users ,controllers: {registrations: 'users/registrations'}
  devise_scope :user do
    root 'users/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :themes
  resources :dashboard
  resources :categories
  resources :animation_datas
  resources :user_animations

  scope "/categories/:id/" do
    get "sub_categories" => 'categories#show'

    scope "sub_categories/:sub_category_id/" do
      get "animations" => 'animation_datas#show'

        scope "animations/:animation_name" do
            get "purchase" => 'user_animations#new'
            get "demo" => 'animation_datas#demo'
        end
        scope "/animations/:animation_data_id/" do
          get "purchase" => 'user_animations#new'
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


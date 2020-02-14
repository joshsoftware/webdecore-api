Rails.application.routes.draw do
  devise_for :users ,controllers: { registrations: 'users/registrations',
                                    confirmations: 'users/confirmations',
                                    passwords: 'users/passwords'
                                  }
  devise_scope :user do
    root 'users/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
    patch 'users/confirm' => 'users/confirmations#confirm'
  end

  resources :dashboard
  resources :categories
  resources :animation_datas
  resources :user_animations, only: [:index,:create]
  # get 'welcome/index'
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

      get "edit_sub_category" => "categories#edit_sub_category"
      patch "edit_sub_category" => "categories#update_sub_category"
      put "edit_sub_category" => "categories#update_sub_category"
      delete "destroy_sub_category" => "categories#destroy_sub_category"

        scope "animations/:animation_data_id" do
            get "purchase" => 'user_animations#new'
            get "demo" => 'animation_datas#demo'
            get "edit_animation" => 'animation_datas#edit'
            delete 'destroy_animation' => 'animation_datas#destroy_animation'
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

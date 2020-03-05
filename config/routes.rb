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
  resources :user_animations, except: [:new]

  get "animation_datas/new" => "animation_datas#new"
  post "animation_datas/new" => "animation_datas#create"
  get "my_animations" => "animation_datas#my_animations"

  get 'user_animations/:id' => 'user_animations#inactive'
  get 'users_details' => 'dashboard#users_details'
  get 'order_details' => 'dashboard#order_details'

  scope "/categories/:id/" do
    get "sub_categories" => 'categories#show'
    get "new" => 'categories#new_sub_category', as: :new_sub_category
    post "new" => 'categories#create_sub_category'

    scope "sub_categories/:sub_category_id/" do
      get "animations" => 'animation_datas#show'
      get "new" => 'animation_datas#new', as: :new_animation
      post "new" => 'animation_datas#create'

      get "edit" => "categories#edit_sub_category", as: :edit_sub_category
      patch "edit" => "categories#update_sub_category"
      delete "destroy" => "categories#destroy_sub_category", as: :destroy_sub_category

        scope "animations/:animation_data_id" do
            get "purchase" => 'user_animations#new'
            get "demo" => 'animation_datas#demo'

            get "edit" => 'animation_datas#edit', as: "edit_animation"
            patch "edit" => 'animation_datas#update'
            delete 'destroy' => 'animation_datas#destroy', as: :destroy_animation
        end
    end
  end

  scope "animations/:animation_data_id" do
    get "user_animation_demo" => 'animation_datas#demo'
    get "purchase_user_animation" => 'user_animations#new'
  end

  namespace :api do
    namespace :v1 do
      resources :animation_datas
      get '/animation_datas' , to: 'animation_datas#index'
    end
  end
end

Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    resources :themes
    root 'devise/sessions#new'
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users, controllers: {sessions: "users/sessions"}
  resources :dashboard

      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
 

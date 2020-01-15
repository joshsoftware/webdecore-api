Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    root to: "devise/sessions#new"
  end
  resources :dashboard

  resources :users do
    resources :assets
  end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

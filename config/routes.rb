Rails.application.routes.draw do
  get 'events/index'
  # devise_for :users
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  devise_for :users, controllers: { 
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
end

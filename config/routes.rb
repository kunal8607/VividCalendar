Rails.application.routes.draw do
  # get 'calendars/index'
  # get 'calendars/show'
  get 'events/index'
  # devise_for :users
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :calendars, only: [:index, :show] 

  devise_for :users, controllers: { 
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }
end

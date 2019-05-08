Rails.application.routes.draw do
  get 'users/show'
  root 'events#index'
  get 'static_pages/index'
  get 'static_pages/secret'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :events
  resources :users, only: [:show, :index, :edit, :update]


end

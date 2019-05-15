Rails.application.routes.draw do
  #get 'users/show'
  root 'events#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :events do
   resources :attendances, only: [:create, :index]
   resources :avatars, only: [:create]
 end
  resources :users, only: [:show, :index, :edit, :update]
  resources :static_pages_secret_index_path , only: [:index]
  resources :static_pages, only: [:index]
end

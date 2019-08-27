Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  get '/home/about' => 'home#about'
  resources :books, only:[:show, :edit, :index, :destroy, :create, :update]
  get 'books' => 'books#index'
end
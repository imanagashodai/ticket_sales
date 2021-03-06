Rails.application.routes.draw do
  root "pages#index"
  get 'purchases/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete "users/delete"
  resources :users
  resources :teams
  resources :grounds
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
end

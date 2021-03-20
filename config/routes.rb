Rails.application.routes.draw do
  root "pages#index"
  get 'purchases/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete "users/delete"
  resources :users, only: [:new, :create, :show, :edit]
  resources :teams, only: [:index, :show]
  resources :grounds
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  
  namespace :admin do
    get "/" => "pages#index"
    resources :teams
    resources :grounds, only: [:index, :new, :create, :show,  :edit, :destroy]
    resources :users, only: [:index, :new, :create, :show,  :edit, :destroy]
    resources :seatgroups, only: [:index, :new, :create, :show,  :edit, :destroy]
    resources :games, only: [:index, :new, :create, :show,  :edit, :destroy]
  end
end

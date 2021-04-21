Rails.application.routes.draw do
  root "pages#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :games, only: [:show, :create]
  resources :users, except: :index
  resources :carts, only: [:create, :destroy, :show]
  resources :teams, only: [:index, :show]
  resources :grounds
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  
  namespace :admin do
    get "/" => "teams#index"
    get "teams/search" => "teams#search"
    get "teams/reset" => "teams#reset"
    resources :teams, except: :show
    get "grounds/search" => "grounds#search"
    get "grounds/reset" => "grounds#reset"
    resources :grounds, except: :show
    get "users/search" => "users#search"
    get "users/reset" => "users#reset"
    resources :users, only: [:index, :destroy]
    get "blockedusers/search" => "blockedusers#search"
    get "blockedusers/reset" => "blockedusers#reset"
    resources :blockedusers, only: [:index, :destroy]
    get "seatgroups/search" => "seatgroups#search"
    get "seatgroups/reset" => "seatgroups#reset"
    resources :seatgroups, except: :show
    get "seats/search" => "seats#search"
    get "seats/reset" => "seats#reset"
    resources :seats, except: :show
    get "tickets/search" => "tickets#search"
    get "tickets/reset" => "tickets#reset"
    resources :tickets, except: :show
    get "purchases/search" => "purchases#search"
    get "purchases/reset" => "purchases#reset"
    resources :purchases, except: :show
    get "games/search" => "games#search"
    get "games/reset" => "games#reset"
    resources :games, except: :show
    get "carts/search" => "carts#search"
    get "carts/reset" => "carts#reset"
    resources :carts, except: :show
  end
  
end
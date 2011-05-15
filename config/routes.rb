SARMS::Application.routes.draw do
  get "sign_in" => "sessions#new", :as => "sign_in"
  get "sign_out" => "sessions#destroy", :as => "sign_out"
  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "sessions#new"
  resources :users
  resources :sessions
end

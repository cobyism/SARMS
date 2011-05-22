SARMS::Application.routes.draw do
  get "dashboard" => "dashboard#index", :as => "dashboard"

  resources :responses

  resources :at_risk_events

  resources :notes

  resources :attendances

  resources :performances

  resources :activities

  resources :assessments

  resources :faculty_assignments

  resources :enrollments

  resources :units

  get "sign_in" => "sessions#new", :as => "sign_in"
  get "sign_out" => "sessions#destroy", :as => "sign_out"
  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "dashboard#index"
  resources :users
  resources :sessions
end

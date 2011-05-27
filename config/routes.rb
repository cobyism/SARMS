SARMS::Application.routes.draw do
  get "dashboard" => "dashboard#index", :as => "dashboard"

  resources :faculty_assignments

  resources :enrollments do
      resources :notes, :shallow => true
      resources :at_risk_events, :shallow => true do
        resources :responses, :shallow => true
      end
      resources :attendances, :shallow => true
      resources :performances, :shallow => true
  end

  resources :units do
    resources :enrollments, :shallow => true
    resources :faculty_assignments, :shallow => true
    resources :activities, :shallow => true do
        resources :attendances, :shallow => true
      end
    resources :assessments, :shallow => true do
      resources :performances, :shallow => true
    end
  end
  
# resources :activities

  get "sign_in" => "sessions#new", :as => "sign_in"
  get "sign_out" => "sessions#destroy", :as => "sign_out"
  get "sign_up" => "users#new", :as => "sign_up"
  root :to => "dashboard#index"
  resources :users do 
    resources :enrollments, :shallow => true
    resources :faculty_assignments, :shallow => true
  end
  resources :sessions
end

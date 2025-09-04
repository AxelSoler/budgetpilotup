Rails.application.routes.draw do
  get "ai/show"
  resource :session
  resources :passwords, param: :token
  resources :users, only: [ :new, :create ]
  resources :transactions, only: [ :index, :new, :create, :show ] do
    post :categorize_with_ai, on: :collection
  end
  resources :categories, only: [ :index, :create, :update, :destroy ]
  resources :dashboard, only: [ :index ]
  resources :stats, only: [ :index ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  get "dashboard", to: "dashboard#index", as: "dashboard"
end

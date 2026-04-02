Rails.application.routes.draw do
  get "home/index", as: :home
  root "home#index"

  get "dashboard", to: "dashboard#index", as: :dashboard

  # rota para a api
  get "/inventory/total", to: "dashboard#total_inventory"
  resources :stock_movements, except: [ :destroy ] # impede a exlusão de uma movimentação estoque
  resources :items
  resources :brands
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end

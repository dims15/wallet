Rails.application.routes.draw do
  get "home/index"
  root 'home#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'stock/new', to: 'stocks#new', as: 'new_stock'
  get 'stock/fetch', to: 'stocks#fetch', as: 'fetch_stock'

  namespace :transactions do
    resources :deposits, only: [:new, :create]
    resources :withdraws, only: [:new, :create]
    resources :transfers, only: [:new, :create]
    resources :check_balance, only: [:new]
  end

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

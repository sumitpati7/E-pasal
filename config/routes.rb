Rails.application.routes.draw do
  devise_for :vendors, controllers: {
    sessions: "vendors/sessions",
    registrations: "vendors/registrations",
    unlocks: "vendors/unlocks",
    passwords: "vendors/passwords",
    omniauth: "vendors/omniauth",
    confirmations: "vendors/confirmations"
  }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest


  root "vendors#index"

  # Resources
  resources :product_categories, only: [ :new, :create, :edit, :update, :index, :destroy ]
  resources :vendors, only: %i[new create index edit show]
  resources :products, only: %i[new create index edit update destroy]
  resources :orders, only: %i[ index ]

 namespace :api do
    namespace :v1 do
      resources :products, only: [ :index, :show ] do
        resources :comments, only: [ :destroy, :create ]
      end
      resources :product_categories, only: [ :index, :show ]
      resources :vendors, only: [ :index, :show ]
      # resources :orders, only: [ :index, :show]
      resources :users do
          resources :orders, only: [ :index, :create ]
      end
      devise_for :users, controllers: {
        registrations: "api/v1/sign_up",
        sessions: "api/v1/sign_in"

  }
    end
 end
end

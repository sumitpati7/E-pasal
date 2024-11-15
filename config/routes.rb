Rails.application.routes.draw do
  devise_for :vendors, controllers: {
    sessions: "vendors/sessions",
    registrations: "vendors/registrations",
    unlocks: "vendors/unlocks",
    passwords: "vendors/passwords",
    omniauth: "vendors/omniauth",
    confirmations: "vendors/confirmations"
  }
  devise_for :users
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

 namespace :api do
    namespace :v1 do
      resources :products
      resources :product_categories, only: [ :index ]
      resources :vendors, only: [ :index, :show ]
    end
 end
end

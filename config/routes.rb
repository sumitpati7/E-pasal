Rails.application.routes.draw do
  devise_for :vendors, controllers: {
    sessions: 'vendors/sessions',
    registrations: 'vendors/registrations',
    unlocks: 'vendors/unlocks',
    passwords: 'vendors/passwords',
    omniauth: 'vendors/omniauth',
    confirmations: 'vendors/confirmations'
  }
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Root path for unauthenticated vendors

  root "vendors#show"

  # Resources
  resources :vendors, only: %i[new create index edit show]
  resources :products, only: %i[ new create ]

  # Default root (fallback) if other conditions are not met
  # root to: redirect("/vendors/sign_in")
end

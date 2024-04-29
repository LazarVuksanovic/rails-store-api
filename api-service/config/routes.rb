# config/routes.rb
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show, :create, :update, :destroy] do
        member do
          put 'update_price', to: 'products#update_price'
        end
      end
      resources :orders, only: [:index, :show, :create, :update, :destroy] do
        member do
          put 'update_status', to: 'orders#update_status'
        end
      end
      resources :categories, only: [:index, :show, :create, :update, :destroy]
      resources :specifications, only: [:index, :show, :create, :update, :destroy]
    end
  end

  # Other routes...

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

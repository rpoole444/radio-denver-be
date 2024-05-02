Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :password_resets, only: [:new, :create, :edit, :update]
    end
  end
end

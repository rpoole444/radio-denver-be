Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
      resources :sessions, only: [:create, :destroy]
    end
  end
end

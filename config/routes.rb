Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update, :destroy] do
        resources :audio_files, only: [:index, :show, :update, :create, :destroy]
      end

      resources :sessions, only: [:create, :destroy]

      resources :password_resets, only: [:create] do
        patch ':token', to: 'password_resets#update', on: :collection, as: :update_with_token
      end
    end
  end
end

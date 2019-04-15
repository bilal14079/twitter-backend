Rails.application.routes.draw do
  resources :likes
  resources :notifications
  get 'rooms/show'

  namespace :api do
    namespace :v1 do
      resources :likes
      # resources :notifications
      get 'rooms/show'
      devise_for :admin_users, ActiveAdmin::Devise.config
      ActiveAdmin.routes(self)
      devise_for :users, :controllers => {:registrations => "api/v1/registrations", :sessions => "api/v1/sessions", omniauth_callbacks: 'omniauth'}

      resources :users do
        member do
          get :following, :followers
          patch :follow, :unfollow
        end
        collection do
          get 'search/:search_value', to: 'users#search'
        end
      end
    
      resources :tweets do
        member do
          put 'add_like'
          patch 'add_like'
        end
        resources :comments
      end
      post 'tweets/:tweet_id/likes' => 'likes#create', :as => :like_tweet
      post 'tweets/:tweet_id/comments' => 'comments#create', :as => :create_comment
      delete '/tweets/:tweet_id/comments/:id' => 'comments#destroy', :as => :destroy_comment
      put '/tweets/:tweet_id/comments/:id' => 'comments#update', :as => :update_comment
    
      get 'home/index'
      get 'notifications', to: "users#notifications"
      root :to => "home#index"
    end
  end

  
  
  resources :users do
    member do
      get :following, :followers
      patch :follow, :unfollow
    end
    collection do
      get :search
    end
  end

  resources :tweets do
    member do
      put 'add_like'
      patch 'add_like'
    end
    resources :comments
  end
  post 'tweets/:tweet_id/likes' => 'likes#create', :as => :like_tweet
  post 'tweets/:tweet_id/comments' => 'comments#create', :as => :create_comment
  delete '/tweets/:tweet_id/comments/:id' => 'comments#destroy', :as => :destroy_comment
  put '/tweets/:tweet_id/comments/:id' => 'comments#update', :as => :update_comment

  get 'home/index'
  get 'notifications', to: "users#notifications"
 
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"

  # root :to => "rooms#show"
end

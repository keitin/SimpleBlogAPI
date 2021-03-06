Rails.application.routes.draw do
  get 'top/index'

  root 'top#index'
  namespace :api, default: {format: :json} do
    resources :sessions, only: [:create]
    resources :users, only: [:create] do
      member do
        resources :notices, only: [:index, :update] do
          collection do
            get 'count'
          end
        end
        post   'follow'
        delete 'unfollow'
        get    'following'
        get    'followers'
        get    'is_follow'
        resources :blocks, only: [:create, :destroy] do
          collection do
            get   'is_blocked'
        end
        end
      end
    end
    resources :blogs do
      collection do
        get 'following'
        get 'search'
      end
      resources :likes, only: [:create, :destroy] do
        collection do
          get   'is_like'
        end
      end
    end
    resources :reports, only: [:create]
    resources :comments, only: [:index, :create]
    resources :images, only: [:create]
    resources :texts, only: [:create]

  end
end

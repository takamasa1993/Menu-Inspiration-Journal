Rails.application.routes.draw do

  root 'user/homes#top'

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions',
    passwords: 'user/passwords'
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  scope module: :user do
    get 'about', to: 'homes#about', as: 'about'

    resources :homes

    resources :users, only: [:show, :edit, :update, :destroy] do
      collection do
        get 'my_page', to: 'users#show'
        get 'information/edit', to: 'users#edit'
        patch 'information', to: 'users#update'
        get 'unsubscribe', to: 'users#unsubscribe'
        patch 'withdraw', to: 'users#withdraw'
      end
      member do
        post 'follow', to: 'follows#create'
        delete 'unfollow', to: 'follows#destroy'
      end
    end

    resources :posts do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :searches, only: [:index]
  end

  namespace :admin do
    get 'dashboard/index'
    resources :posts, only: [:show] do
      resources :comments, only: [:destroy]
    end

    root to: 'dashboard#index'
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resources :posts, only: [:index, :show, :edit, :update, :destroy]
    end
    resources :genres, except: [:show]
    resources :ingredients, only: [:index, :show, :update]
  end
end
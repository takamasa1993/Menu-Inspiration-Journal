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

  devise_scope :user do
    post 'guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

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
        get 'liked_posts', to: 'users#liked_posts'
        post 'follow', to: 'user_follows#create', as: 'follow'
        delete 'unfollow', to: 'user_follows#destroy', as: 'unfollow'
        get :following, :followers
      end
    end
    resources :posts do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :searches, only: [:index]
    resources :ingredients, only: [:new, :create]
    get 'genres/:id/posts', to: 'posts#by_genre', as: 'genre_posts'
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
    resources :ingredients, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :new_ingredient_proposals, only: [:index, :update, :destroy] do
      member do
        patch :approve, to: 'new_ingredient_proposals#update', defaults: { status: 'approved' }
        patch :reject, to: 'new_ingredient_proposals#update', defaults: { status: 'rejected' }
      end
    end
    get 'genres/:id/posts', to: 'posts#by_genre', as: 'admin_genre_posts'
  end
end
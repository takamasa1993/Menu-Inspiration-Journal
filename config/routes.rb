Rails.application.routes.draw do
  
  root 'homes#top'

  get 'about', to: 'homes#about', as: 'about'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

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

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :genres, except: [:show]
    resources :ingredients, only: [:index, :show, :update]
  end
end

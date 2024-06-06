Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :users, only: [:edit, :update, :destroy, :show] do
    collection do
      get 'mypage', to: 'users#mypage'
      get 'search', to: 'users#search'
      get 'search_results', to: 'users#search_results'
    end
    member do
      get 'liked_posts', to: 'users#liked_posts'
    end
  end

  post 'users/guest_sign_in', to: 'users#guest_sign_in'

  resources :posts do
    collection do
      get 'search', to: 'posts#search'
      get 'search_results', to: 'posts#search_results'
    end
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :groups do
    resources :user_groups, only: [:create, :destroy]
  end

  namespace :admin do
    resources :users, except: [:new, :create]
    resources :posts, except: [:new, :create]
    resources :comments, except: [:new, :create]
    resources :groups, except: [:new, :create]
  end
end

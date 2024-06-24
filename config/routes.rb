Rails.application.routes.draw do
  root 'homes#top'
  get 'about', to: 'homes#about'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }

  resources :users, only: [:edit, :update, :destroy, :show] do
    collection do
      get 'mypage', to: 'users#mypage'
      get 'search', to: 'users#search'
    end
    member do
      get 'liked_posts', to: 'users#liked_posts'
    end
  end

  post 'users/guest_sign_in', to: 'users#guest_sign_in'

  resources :posts do
    member do
      post 'toggle_like'
    end
    collection do
      get 'search', to: 'posts#search'
    end
    resources :comments, only: [:create, :destroy]
  end

  resources :groups do
    member do
      post 'join'
      delete 'leave'
    end
    resources :posts, only: [:new, :create, :index]
    resources :user_groups, only: [:create, :destroy]
  end

  namespace :admin do
    resources :groups
    resources :users, except: [:new, :create]
    resources :posts, except: [:new, :create]
    resources :comments, except: [:new, :create]
  end

  get 'search', to: 'search#index'
end

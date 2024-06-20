Rails.application.routes.draw do
  root 'homes#top'
  get 'about', to: 'homes#about'

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
    member do
      post 'toggle_like'
    end
    collection do
      get 'search', to: 'posts#search'
      get 'search_results', to: 'posts#search_results'
    end
    resources :comments, only: [:create, :destroy], module: 'users'
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
    resources :users, except: [:new, :create]
    resources :posts, except: [:new, :create]
    resources :comments, except: [:new, :create]
    resources :groups, except: [:new, :create]
  end

  get 'admin/groups/manage', to: 'groups#manage', as: :admin_manage_groups
end

Rails.application.routes.draw do
  
  get 'logout', to:'sessions#destroy', as: 'logout'
  get 'signin', to: 'sessions#new', as: 'signin'
  get 'signup', to: 'users#new', as: 'signup'
  get 'edit', to: 'users#edit', as: 'edit'
  get 'reset', to: 'password_resets#new', as: 'reset'
  resources :users
  resources :sessions, only: [:create, :destroy]
  resources :password_resets
  resources :charges, only: [:new, :create]

  resources :wikis

  get 'welcome/index'
  root to: 'welcome#index'
end

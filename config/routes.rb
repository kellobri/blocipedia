Rails.application.routes.draw do
  get 'logout', to:'sessions#destroy', as: 'logout'
  get 'signin', to: 'sessions#new', as: 'signin'
  get 'signup', to: 'users#new', as: 'signup'
  get 'edit', to: 'users#edit', as: 'edit'
  resources :users
  resources :sessions, only: [:create, :destroy]

  get 'welcome/index'
  root to: 'welcome#index'
end

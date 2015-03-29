Rails.application.routes.draw do
  get 'logout', to:'sessions#destroy', as: 'logout'
  get 'signin', to: 'sessions#new', as: 'signin'
  get 'signup', to: 'users#new', as: 'signup'
  resources :users
  resources :sessions

  get 'welcome/index'
  root to: 'welcome#index'
end

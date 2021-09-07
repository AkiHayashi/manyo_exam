Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :sessions, only: %i[new create destroy]
  resources :users 
  namespace :admin do
    resources :users
  end
  resources :tasks
end

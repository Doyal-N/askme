Rails.application.routes.draw do
  root 'users#index'

  resources :users, except: %i[destroy]
  resources :questions
end

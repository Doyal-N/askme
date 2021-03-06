Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :sessions, only: %i[new create destroy]

  resources :questions, except: %i[show new index], shallow: true do
    resources :hashtags, only: %i[show]
  end

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end

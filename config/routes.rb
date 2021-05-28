Rails.application.routes.draw do

  # TODO: 不必要なものは削除、resources等

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  root 'home#index'

  resources :courses do
    resources :chapters
  end
  
end

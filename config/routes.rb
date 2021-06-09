Rails.application.routes.draw do

  # TODO: 不必要なものは削除、resources等
  # TODO: アルファベット順にソート

  root 'home#index'

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

  resources :courses do
    resources :chapters
  end
  resources :chapters, only: [] do
    resources :sections
  end
  resources :sections, only: [] do
    post   'complete'
    delete 'incomplete'
    resource :review_sections, only: [:create, :destroy]
  end

  resources :review_stages

  resources :articles do
    resource :favorites, only: [:create, :destroy]
  end
  resources :categories, only: [:index]
  resources :favorites, only: [:index]

  namespace :api, format: 'json' do
    get 'preview', to: 'previews#preview'
  end
end

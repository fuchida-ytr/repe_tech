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

  # コース関連
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
  resources :review_stages, only: [:index, :create, :update, :destroy]
  resources :review_sections, only: [:index] do
    get '/correct', to: 'review_sections#correct', as: 'correct'
    get '/incorrect', to: 'review_sections#incorrect', as: 'incorrect'
  end
  resource :review_sections, only: [] do
    get '/courses/:course_id', to: 'review_sections#course_index', as: 'course_index'
    get '/courses/:course_id/stages/:stage_id', to: 'review_sections#course_show', as: 'course_show'
  end
  

  # 記事投稿関連
  resources :articles do
    resource :favorites, only: [:create, :destroy]
  end
  resources :categories, only: [:index]
  resources :favorites, only: [:index]

  # 共通
  namespace :api, format: 'json' do
    get 'preview', to: 'previews#preview'
  end
end

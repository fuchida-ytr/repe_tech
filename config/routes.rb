Rails.application.routes.draw do
  # production
  root 'home#index'

  resources :courses, only: %i[index create show update destroy] do
    resources :chapters, only: %i[create show]
  end
  resources :chapters, only: [] do
    resources :sections, only: %i[new create show edit]
  end
  resources :sections, only: [] do
    post   'complete'
    delete 'incomplete'
    resource :review_sections, only: %i[create destroy]
  end

  # 記事投稿関連
  resources :articles do
    resource :favorites, only: %i[create destroy]
  end
  resources :categories, only: [:index]
  resources :favorites, only: [:index]

  # コース/記事検索
  get 'search' => 'home#search', as:'search'

  # TODO: 不必要なものは削除、resources等
  # TODO: アルファベット順にソート



  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }


  
  resources :review_stages, only: %i[index create update destroy]
  resources :review_sections, only: [:index] do
    get '/correct', to: 'review_sections#correct', as: 'correct'
    get '/incorrect', to: 'review_sections#incorrect', as: 'incorrect'
  end
  resource :review_sections, only: [] do
    get '/courses/:course_id', to: 'review_sections#course_index', as: 'course_index'
    get '/courses/:course_id/stages/:stage_id', to: 'review_sections#course_show', as: 'course_show'
  end

  

  # 共通
  namespace :api, format: 'json' do
    get 'preview', to: 'previews#preview'
  end
end

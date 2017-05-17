Rails.application.routes.draw do
  resources :story_comments
  # resources :image_comments
  # resources :images
  devise_for :users, class_name: 'FormUser',
    :controllers => {
      omniauth_callbacks: 'omniauth_callbacks',
      registrations: 'registrations',
    }
  resources :users, only: [ :show ]
  resources :places, only: [ :show ]
  resources :stories do
    resources :cards
  end
  resources :relationships, only: [ :create, :destroy ]
  resources :story_loves, only: [ :create, :destroy ]

  resources :signed_urls, only: :index # GET the key to send file to S3
  get 'home' => 'pages#home', as: 'home'
  root 'pages#landing'
end

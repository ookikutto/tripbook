Rails.application.routes.draw do

  resources :image_comments
  resources :images
  devise_for :users, class_name: 'FormUser',
    :controllers => {
      omniauth_callbacks: 'omniauth_callbacks',
      registrations: 'registrations'
    }

  resources :cards, only: [:new, :create, :show]
  resources :stories do
    resources :cards
  end

  get 'home' => 'pages#home', as: 'home'


  resources :signed_urls, only: :index # GET the key to send file to S3
  root 'pages#landing'
end

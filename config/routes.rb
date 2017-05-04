Rails.application.routes.draw do

  resources :image_comments
  resources :images
  devise_for :users, class_name: 'FormUser',
    :controllers => {
      omniauth_callbacks: 'omniauth_callbacks',
      registrations: 'registrations'
    }

  resources :cards, only: [:new, :create, :show]
  resources :stories

  get 'home' => 'pages#home', as: 'home'

  root 'pages#landing'
end

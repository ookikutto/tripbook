Rails.application.routes.draw do

  devise_for :users, class_name: 'FormUser',
    :controllers => {
      omniauth_callbacks: 'omniauth_callbacks',
      registrations: 'registrations'
    }

  resources :cards, only: [:new, :create, :show]
  
  get 'pages/landing', as: 'landing'
  get 'pages/home', as: 'home'

  root 'pages#landing'
end

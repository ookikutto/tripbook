Rails.application.routes.draw do

  get 'homes/home'

  devise_for :users, class_name: 'FormUser',
    :controllers => {
      omniauth_callbacks: 'omniauth_callbacks',
      registrations: 'registrations'
    }

  resources :cards, only: [:new, :create, :show]
  get 'pages/landing'

  root 'pages#landing'
end

Rails.application.routes.draw do

  get 'homes/home'

  devise_for :users, class_name: 'FormUser',
    :controllers => {
      omniauth_callbacks: 'omniauth_callbacks',
      registrations: 'registrations'
    }

  get 'pages/landing'

  root 'pages#landing'
end

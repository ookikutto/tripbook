Rails.application.routes.draw do

  devise_for :users
  get 'pages/landing'

  get 'pages/home'

  root 'pages#landing'
end

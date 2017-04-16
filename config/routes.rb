Rails.application.routes.draw do

  get 'pages/landing'

  get 'pages/home'

  root 'pages#landing'
end

Rails.application.routes.draw do
  root 'home#index'

  resources :search, only: [:index]
end

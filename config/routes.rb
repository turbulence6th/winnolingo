Rails.application.routes.draw do

  root 'index#index'

  resources :users

  resources :users do
    resources :requests
    resources :suggestions
  end

end

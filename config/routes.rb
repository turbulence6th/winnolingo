Rails.application.routes.draw do

  root 'index#index'

  resources :users, :path => '/'

  resources :users, :path => '/' do
    resources :requests
    resources :suggestions
  end

end

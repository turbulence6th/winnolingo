Rails.application.routes.draw do
  
  ActiveAdmin.routes(self)

  resources :index, :path => "/" do
    post "login", :to => "users#login", :on => :collection
    get "verify_email", :to => "users#verify_email", :on => :collection
  end
  
  resources :requests

  resources :users do
    resources :suggestions
  end

end

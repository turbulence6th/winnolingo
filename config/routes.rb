Rails.application.routes.draw do
  
  ActiveAdmin.routes(self)

  resources :index, :path => "/" do
    get "login", :to => "users#login", :on => :collection
    get "logout", :to => "users#logout", :on => :collection
    get "verify_email", :to => "users#verify_email", :on => :collection
  end
  
  resources :requests do 
    resources :suggestions
  end

  resources :users, :except => [:destroy] do
    delete :destroy, :on => :collection
  end

end

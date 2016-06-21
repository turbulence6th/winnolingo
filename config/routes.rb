Rails.application.routes.draw do
  
  ActiveAdmin.routes(self)
  
  root "index#index"
  
  get "login", :to => "users#login"
  get "logout", :to => "users#logout"
  get "verify_email", :to => "users#verify_email"
  
  resources :requests do 
    resources :suggestions
  end

  resources :users, :except => [:edit, :update, :destroy] do
    get :edit, :on => :collection
    put :update, :on => :collection
    delete :destroy, :on => :collection
  end

end

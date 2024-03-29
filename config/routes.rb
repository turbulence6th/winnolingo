Rails.application.routes.draw do
  
  ActiveAdmin.routes(self)
  
  root "index#index"
  
  get "index", :to => "index#index"
  get "login", :to => "users#login"
  get "logout", :to => "users#logout"
  get "verify_email", :to => "users#verify_email"
  
  resources :requests do 
    resources :suggestions
  end

  resources :users, :except => [:edit, :update, :destroy], :param => "user_name-:id" do
    get :edit, :on => :collection
    put :update, :on => :collection
    delete :destroy, :on => :collection
  end
  
  resources :blocks, :only => [:index, :create] do
    delete :destroy, :on => :collection
  end

end

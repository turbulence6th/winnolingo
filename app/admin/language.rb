ActiveAdmin.register Language do
  permit_params :name
  
  filter :users
  filter :requests
  filter :questions
  filter :name
  
  
end

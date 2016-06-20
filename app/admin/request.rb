ActiveAdmin.register Request do
  permit_params :user_id, :category, :name, :award, :privacy, :description, 
      :last_date, :extra_request, :deleted, :language_ids => []
      
  filter :user
  filter :languages
  filter :category, :as => :select, :collection => Request.categories
  filter :name
  filter :award
  filter :privacy
  filter :description
  filter :last_date
  filter :extra_request
  filter :deleted
  filter :created_at
  filter :updated_at
      
  index do
    id_column
    column :user
    column :category
    column :name
    column :award
    column :privacy
    column :description
    column :last_date
    column :extra_request
    column :deleted
    column :created_at
    column :updated_at
    actions
  end
      
  form do |f|
    f.inputs do
      f.input :user
      f.input :category, :as => :select, :collection => Request.categories.keys
      f.input :name
      f.input :award
      f.input :privacy
      f.input :description
      f.input :last_date
      f.input :extra_request
      f.input :deleted
      f.input :languages
    end
    f.actions
  end
  
end

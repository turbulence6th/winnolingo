ActiveAdmin.register Suggestion do
  permit_params :user_id, :request_id, :text, :successful, :deleted

  index do
    id_column
    column :user
    column :request
    column :text
    column :successful
    column :deleted
    column :created_at
    column :updated_at
    actions
  end

end

ActiveAdmin.register Question do
  permit_params :language_id, :name, :answers_raw, :right_answer_index
  
  filter :language
  filter :name
  filter :right_answer_index
  
  index do
    id_column
    column :language
    column :name
    column :answers
    column :right_answer_index
    actions
  end
  
  form do |f|
    f.inputs do
      f.input :language
      f.input :name
      f.input :answers_raw, :as => :text
      f.input :right_answer_index
    end
    f.actions
  end
  
end

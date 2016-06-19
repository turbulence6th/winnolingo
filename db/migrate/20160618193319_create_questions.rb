class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :language
      
      t.text :name
      t.string :answers, :array => true
      t.integer :right_answer_index
    end
  end
end

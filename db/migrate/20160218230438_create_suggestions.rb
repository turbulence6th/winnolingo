class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.references :user
      t.references :request
      
      t.string :text

      t.timestamps :null => false
    end
  end
end

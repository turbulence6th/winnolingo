class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.references :user, :index => true
      t.references :request, :index => true
      
      t.string :text
      t.boolean :successful, :default => false
      
      t.boolean :deleted, :default => false

      t.timestamps :null => false
    end
  end
end

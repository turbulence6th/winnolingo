class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user
      
      t.integer :category
      t.string :description
      
      #award_type
      #award_amount
      
      t.date :deadLine
      t.boolean :showSuggestions
      t.integer :onVote
      
      t.boolean :active

      t.timestamps null: false
    end
  end
end

class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user
      
      t.integer :category
      t.string :name
      t.string :award
      
      t.references :request_language
      
      t.boolean :privacy
      t.text :description
      t.datetime :last_date
      t.boolean :extra_request
      
      t.timestamps :null => false
    end
  end
end

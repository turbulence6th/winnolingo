class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user
      
      t.integer :category
      t.string :name
      t.string :award
      
      t.boolean :privacy, :default => false
      t.text :description
      t.datetime :last_date
      t.boolean :extra_request, :default => false
      
      t.timestamps :null => false
    end
  end
end

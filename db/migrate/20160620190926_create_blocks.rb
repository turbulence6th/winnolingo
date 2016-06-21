class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.references :blocker, :references => :user, :index => true
      t.references :blocked, :references => :user, :index => true
      
      t.timestamps null: false
    end
  end
end

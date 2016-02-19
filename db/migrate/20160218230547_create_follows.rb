class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :follower, :references => :user
      t.references :followed, :references => :user
      
      t.timestamps null: false
    end
  end
end

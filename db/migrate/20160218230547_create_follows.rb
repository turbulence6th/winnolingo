class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :follower, :references => :user, :index => true
      t.references :followed, :references => :user, :index => true
      
      t.timestamps :null => false
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :index => true
      t.string :password_digest
      
      t.string :name
      t.string :surname
      t.integer :gender
      t.date :birthday
      t.text :address
      
      t.string :email, :index => true
      t.string :email_token
      
      t.string :mobile
      t.string :mobile_token
      
      t.boolean :showFollowings
      t.boolean :showFollowers
      
      t.integer :role
      t.boolean :bulletin
      t.string :facebookID  
      t.boolean :verified
      
      t.boolean :deleted

      t.timestamps :null => false
    end
  end
end

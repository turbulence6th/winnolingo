class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| 
      t.string :email, :index => true
      t.uuid :email_token
      
      t.string :password_digest
      
      t.string :name
      t.integer :gender
      t.date :birthday
      t.text :address
      
      t.string :mobile, :index => true
      t.uuid :mobile_token
      
      t.boolean :show_followings, :default => :true
      t.boolean :show_followers, :default => :true
      
      t.integer :role, :default => User.roles[:member]
      t.integer :account_type
      t.boolean :bulletin
      
      t.string :facebook_id
      t.string :google_id
      t.string :twitter_id
      
      t.boolean :verified, :default => false
      t.boolean :deleted, :default => false

      t.timestamps :null => false
    end
  end
end

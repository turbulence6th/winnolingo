class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| 
      t.string :email, :index => true
      t.string :email_token
      
      t.string :password_digest
      
      t.string :name
      t.integer :account_type
      t.date :birthday
      t.string :city
      t.string :country
      
      t.string :mobile, :index => true
      t.string :mobile_token
      
      t.boolean :show_followers, :default => :true
      t.boolean :show_followeds, :default => :true
      
      t.integer :role, :default => User.roles[:member]
      t.boolean :bulletin, :default => :true
      
      t.string :facebook_id
      t.string :google_id
      t.string :twitter_id
      
      t.boolean :verified, :default => false
      t.boolean :deleted, :default => false

      t.timestamps :null => false
    end
  end
end

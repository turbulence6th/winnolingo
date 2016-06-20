class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, :index => true
      t.string :auth_token, :index => true
      t.string :device_id, :index => true
      t.string :device_type, :index => true
      t.string :push_token
      t.string :language
      t.timestamps null: false
    end
  end
end

ActiveAdmin.register User do
  permit_params :email, :email_token, :password, :name, :account_type, :birthday, :address,
    :mobile, :mobile_token, :show_followers, :show_followeds, :role, :bulletin,
    :facebook_id, :google_id, :twitter_id, :verified, :deleted

  form do |f|
    f.inputs do
      f.input :email
      f.input :email_token
      f.input :password if object.new_record?
      f.input :name
      f.input :account_type, :as => :select, :collection => User.account_types.keys
      f.input :birthday
      f.input :address
      f.input :mobile
      f.input :mobile_token
      f.input :show_followers
      f.input :show_followeds
      f.input :role, :as => :select, :collection => User.roles.keys
      f.input :bulletin
      f.input :facebook_id
      f.input :google_id
      f.input :twitter_id
      f.input :verified
      f.input :deleted
    end
    f.actions
  end
  

end

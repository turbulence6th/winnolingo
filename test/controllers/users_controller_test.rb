require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  #Register test cases
  test "register" do
    post(:create, { :user => { :name => "Oguz", :email => "turbulence6th@gmail.com", 
      :password => "oguzTanrikulu", :account_type => "male" }, :session => {
      :device_type => "browser", :device_id => SecureRandom.uuid, :push_token => SecureRandom.uuid} })
    user = User.find_by(:email => "turbulence6th@gmail.com")
    assert_redirected_to "/"
    assert cookies[:auth_token]
  end
  
  test "register_invalid" do
    post(:create, { :user => { :name => "Oguz2", :email => "turbulence6th@gmail.com", 
      :password => "oguzTanrikulu", :account_type => "male" }, :session => {
      :device_type => "browser", :device_id => SecureRandom.uuid, :push_token => SecureRandom.uuid} })
    user = User.find_by(:email => "turbulence6th@gmail.com")
    assert_template :new
    assert !cookies[:auth_token]
  end
  
  #Verify email
  test "verify_email" do
    get(:verify_email, { :token => "bddf6e00-3092-4538-8224-ad86786db6b7" })
    user = User.find_by(:email => "onur.ates@gmail.com")
    assert user.verified
  end
  
  #Verify login
  test "login" do
    user = User.find_by(:email => "onur.ates@gmail.com")
    session_count = user.sessions.count
    login "onur.ates@gmail.com", "onurAtes"
    assert user.sessions.count==session_count+1
    assert cookies[:auth_token]
  end
end

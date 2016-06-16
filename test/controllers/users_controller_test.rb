require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  #Register test cases
  test "register" do
    post(:create, { :user => { :name => "Oguz", :email => "turbulence6th@gmail.com", 
      :password => "oguzTanrikulu" } })
    user = User.find_by(:email => "turbulence6th@gmail.com")
    assert_redirected_to user_path(user)
  end
  
  test "register_invalid" do
    post(:create, { :user => { :name => "Oguz2", :email => "turbulence6th@gmail.com", 
      :password => "oguzTanrikulu" } })
    user = User.find_by(:email => "turbulence6th@gmail.com")
    assert_template :new
  end
end

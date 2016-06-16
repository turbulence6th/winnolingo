require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup do
    @user = User.new
  end
  
  #Password test cases
  test "password" do
    @user.password = "oguzTanrikulu123"
    @user.valid?
    assert @user.errors[:password] == [], @user.errors[:password]
  end
  
  test "password_invalid_character" do
    @user.password = "oguzTanrikulu!'^"
    @user.valid?
    assert @user.errors[:password] != []
  end
  
  test "password_invalid_size" do
    @user.password = "oguzTanrikuluoguzTanrikuluoguzTanrikulu"
    @user.valid?
    assert @user.errors[:password] != []
  end
  
  #Email test cases
  test "email" do
    @user.email = "turbulence6th@gmail.com"
    @user.valid?
    assert @user.errors[:email] == [], @user.errors[:email]
  end
  
  test "email_exits" do
    @user.email = "oguz.tanrikulu@metu.edu.tr"
    @user.valid?
    assert @user.errors[:email] != []
  end
  
end

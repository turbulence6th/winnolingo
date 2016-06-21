require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup do
    @user = User.new
  end
  
  test "not_exists" do
    @user.valid?
    assert @user.errors[:email] != []
    assert @user.errors[:password] != []
    assert @user.errors[:name] != []
    assert @user.errors[:account_type] != []
    
    @user.facebook_id = "11111111111111111"
    @user.valid?
    assert @user.errors[:email] == [], @user.errors[:email]
    assert @user.errors[:password] == [], @user.errors[:password]
  end
  
  #Name test cases
  test "name" do
    @user.name = "Oğuz Tanrıkulu"
    @user.valid?
    assert @user.errors[:name] == [], @user.errors[:name]
  end
  
  test "name_invalid" do
    @user.name = "0ğuz T4nr1kulu"
    @user.valid?
    assert @user.errors[:name] != []
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
  
  #Kind test cases
  test "kind_real_person" do
    @user.account_type = "male"
    @user.valid?
    assert @user.kind == :real_person, @user.kind
  end
  
  test "kind_legal_person" do
    @user.account_type = "public_institution"
    @user.valid?
    assert @user.kind == :legal_person, @user.kind
  end
  
end

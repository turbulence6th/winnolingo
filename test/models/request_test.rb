require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  setup do
    @request = Request.new
  end
  
  test "not_exists" do
    @request.valid?
    assert @request.errors[:user] != []
    assert @request.errors[:category] != []
    assert @request.errors[:name] != []
    assert @request.errors[:award] != []
  end
  
  #User test cases
  test "user" do
    user = User.find_by(:email => "onur.ates@gmail.com")
    @request.user = user
    @request.valid?
    assert @request.errors[:user] == [], @request.errors[:user]
  end
  
  #Category test cases
  test "category" do
    @request.category = "commercial"
    @request.valid?
    assert @request.errors[:category] == [], @request.errors[:category]
  end
  
  #Name test cases
  test "name" do
    @request.name = "Galatasaray'a yeni slogan buluyoruz."
    @request.valid?
    assert @request.errors[:name] == [], @request.errors[:name]
  end
  
  #Award test cases
  test "award" do
    @request.award = "Orjinal imzalı Galatasaray forması"
    @request.valid?
    assert @request.errors[:award] == [], @request.errors[:award]
  end
  
  #Description test cases
  test "description" do
    @request.description= "Galatasaray'ımıza yeni slogan arıyoruz. İlk üçe girenlere ödüller verilecektir."
    @request.valid?
    assert @request.errors[:description] == [], @request.errors[:description]
  end
  
end

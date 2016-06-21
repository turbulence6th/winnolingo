require 'test_helper'

class BlocksControllerTest < ActionController::TestCase
  
  test "index" do
    login "onur.ates@gmail.com", "onurAtes"
    
    get(:index, {:format => :json})
    
    body = JSON.parse(response.body)
    blocks = body["blocks"]
    assert User.find_by(:email => "onur.ates@gmail.com").blockeds.count == blocks.size
  end
  
  test "create" do
    login "onur.ates@gmail.com", "onurAtes"
    
    post(:create, {:user_id => 2, :format => :json})
    assert User.find_by(:email => "onur.ates@gmail.com").blockeds.include?(User.find(2))
  end
  
  test "destroy" do
    login "onur.ates@gmail.com", "onurAtes"
    
    post(:destroy, {:user_id => 4, :format => :json})
    assert !User.find_by(:email => "onur.ates@gmail.com").blockeds.include?(User.find(4))
  end
  
end

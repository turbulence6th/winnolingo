require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  
  #Create test cases
  test "create" do
    login "onur.ates@gmail.com", "onurAtes"
    request_number = Request.count
    
    post(:create, { :request => { :category => "commercial", :name => "Fenerbahçe'ye yeni slogan.", 
      :award => "2000 TL", :privacy => false, :description => "Fenerbahçeye yei slogan arıyoruz.",
      :last_date => "2016-10-10", :extra_request => true } })
      
    assert_redirected_to requests_url(Request.last)
    assert Request.count==request_number+1
  end
  
end

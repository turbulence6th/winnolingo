require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  
  #Create test cases
  test "create" do
    login "onur.ates@gmail.com", "onurAtes"
    request_number = Request.count
    
    post(:create, { :request => { :category => "commercial", :name => "Fenerbahçe'ye yeni slogan.", 
      :award => "2000 TL", :privacy => false, :description => "Fenerbahçeye yei slogan arıyoruz.",
      :last_date => "2016-10-10", :extra_request => true } })
      
    assert_redirected_to request_path(Request.last)
    assert Request.count==request_number+1
  end
  
  test "update" do
    login "onur.ates@gmail.com", "onurAtes"
    request_number = Request.count
    
    put(:update, { :id => 2, :request => { :category => "commercial", :name => "Köpeğime isim arıyorum", 
      :award => "100 TL", :privacy => false, :description => "En güzel isme hesap numarasını verirse ödülünü ileteceğim.",
      :last_date => "2016-10-10", :extra_request => true } })
      
    assert Request.find_by(:name => "Köpeğime isim arıyorum")
    assert Request.count==request_number
  end
  
  test "update_unauthorized" do
    login "oguz.tanrikulu@metu.edu.tr", "oguzTanrikulu123"
    request_number = Request.count
    
    begin
      put(:update, { :id => 2, :request => { :category => "commercial", :name => "Köpeğime isim arıyorum", 
        :award => "100 TL", :privacy => false, :description => "En güzel isme hesap numarasını verirse ödülünü ileteceğim.",
        :last_date => "2016-10-10", :extra_request => true } })
    rescue ActiveRecord::RecordNotFound
    end
      
    assert Request.find_by(:name => "Kedime isim arıyorum")
    assert Request.count==request_number
  end
  
  test "destroy" do
    login "onur.ates@gmail.com", "onurAtes"
    request_valid_count = Request.valid.count
    
    delete(:destroy, { :id => 2 })
    
    assert Request.valid.count==request_valid_count-1
  end
  
  test "destroy_unauthorized" do
    login "oguz.tanrikulu@metu.edu.tr", "oguzTanrikulu123"
    request_valid_count = Request.valid.count
    
    begin
      delete(:destroy, { :id => 2 })
    rescue ActiveRecord::RecordNotFound
    end
    
    assert Request.valid.count==request_valid_count
  end
  
end

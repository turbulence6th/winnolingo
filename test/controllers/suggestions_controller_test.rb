require 'test_helper'

class SuggestionsControllerTest < ActionController::TestCase
  
  test "create" do
    login "onur.ates@gmail.com", "onurAtes"
    suggestion_number = Suggestion.count
    
    post(:create, { :request_id => 1, :suggestion => { :text => "Ultaslan ultraslan oleey." } })
    
    assert Suggestion.count==suggestion_number+1
  end
  
  test "update" do
    
  end
  
end

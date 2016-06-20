require 'test_helper'

class SuggestionTest < ActiveSupport::TestCase
  setup do
    @suggestion = Suggestion.new
  end
  
  test "not_exists" do
    @suggestion.valid?
    assert @suggestion.errors[:user] != []
    assert @suggestion.errors[:request] != []
    assert @suggestion.errors[:text] != []
  end
  
  test "user" do
    user = User.find_by(:email => "onur.ates@gmail.com")
    @suggestion.user = user
    @suggestion.valid?
    assert @suggestion.errors[:user] == [], @suggestion.errors[:user]
  end
  
  test "own_request" do
    @suggestion.request = Request.find(1)
    @suggestion.user = User.find_by(:email => "oguz.tanrikulu@metu.edu.tr")
    @suggestion.valid?
    assert @suggestion.errors[:request] != []
  end
  
  test "text" do
    @suggestion.text = "En büyük Fenerbahçe!"
    @suggestion.valid?
    assert @suggestion.errors[:text] == [], @suggestion.errors[:text]
  end
  
  test "text_already_send" do
    @suggestion.text = "Galatasaray galatasatay cimbombom"
    @suggestion.valid?
    assert @suggestion.errors[:text] != []
  end
  
  test "text_already_send_deleted" do
    @suggestion.text = "Galatasaray galatasatay cimbombom"
    @suggestion.deleted = true
    @suggestion.valid?
    assert @suggestion.errors[:text] == [], @suggestion.errors[:text]
  end
  
  test "suggestion_count" do
    @suggestion.request = Request.find(1)
    @suggestion.user = User.find_by(:email => "onur.demirtas@gmail.com")
    @suggestion.valid?
    assert @suggestion.errors[:request] != []
  end
  
end

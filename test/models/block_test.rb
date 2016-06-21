require 'test_helper'

class BlockTest < ActiveSupport::TestCase
  
  setup do
    @block = Block.new
  end

  test "not_exists" do
    @block.valid?
    assert @block.errors[:blocker] != []
    assert @block.errors[:blocked] != []
  end
  
  test "self_block" do
    user = User.first
    @block.blocker = user
    @block.blocked = user
    @block.valid?
    assert @block.errors[:blocked] != []
  end
  
  test "run" do
    user = User.first
    user2 = User.second
    @block.blocker = user
    @block.blocked = user2
    @block.valid?
    assert @block.errors[:blocked] == [], @block.errors[:blocked]
  end
 
end

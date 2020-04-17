require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @Bob = users(:Bob)
    @Michael = users(:Michael)
    @micropost = microposts(:one)
  end
  
  test "should be invalid when content too longer" do
    @micropost.content = "a"*256
    assert_not @micropost.valid?
  end
  
 
  
  test "should return user" do
    assert_equal @Bob, @micropost.user
  end
  
  
end

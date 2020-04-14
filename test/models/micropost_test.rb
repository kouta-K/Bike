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
  
  test "should be invalid when image and content do not exist" do
    @micropost.content = ""
    @micropost.image = ""
    assert_not @micropost.valid?
  end
  
  test "should be valid when image or content exist" do
    assert @micropost.valid?
    @micropost.content = ""
    assert @micropost.valid?
    
    @micropost.content = "hello"
    @micropost.image=""
    assert @micropost.valid?
  end
  
  test "should return user" do
    assert_equal @Bob, @micropost.user
  end
  
  
end

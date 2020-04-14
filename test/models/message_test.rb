require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = messages(:one)
    @Bob = users(:Bob)
    @group = groups(:one)
  end
  
  test "should be invalid when content is too long and not presence" do
    assert @message.valid?
    @message.content = " "
    assert_not @message.valid?
    @message.content = "a"* 256
    assert_not @message.valid?
    
  end
  
  test "should return use who create message" do
    assert_equal @Bob, @message.user
  end
  
  test "should return group has message" do
    assert_equal @group, @message.group
  end
end

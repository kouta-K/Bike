require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @group = groups(:one)
    @Bob = users(:Bob)
    @Michael = users(:Michael)
    @message = messages(:one)
    @plan = plans(:One)
  end
  
  test "should be valid when valid group" do
    assert @group.valid?
  end
  
  test "should be invalid when introduce is too long and empty" do
    @group.introduce = " "
    assert_not @group.valid?
    @group.introduce = "a"* 256
    assert_not @group.valid?
  end
  
  test "should be invalid when name is too long and empty" do
    @group.name = " "
    assert_not @group.valid?
    @group.name = "a"*31
    assert_not @group.valid?
  end
  
  test "should return user who created group" do
    assert_equal @Bob, @group.user
  end
  
  test "should return messsge that group has" do
    assert @group.messages.include?(@message)
  end
  
  test "should return avtivate use and nonactivate user group has " do
    assert @group.has_members.include?(@Bob)
    assert @group.has_members.include?(@Michael)
  end
  
  test "should return messages group have" do
    assert @group.messages.include?(@message)
  end
  
  test "should return plan group have" do
    assert @group.plans.include?(@plan)
  end
end

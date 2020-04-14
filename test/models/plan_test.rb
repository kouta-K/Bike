require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  def setup
    @plan = plans(:One)
    @participate = participates(:One)
    @Bob = users(:Bob)
  end
  
  test "should be invalid when place or datetime or group_id is not presence" do
    assert @plan.valid?
    @plan.content = ""
    assert_not @plan.valid?
    @plan.content = "雨だったら中止"
    @plan.place = " "
    assert_not @plan.valid?
    @plan.place = "東京タワー"
    @plan.group_id = nil
    assert_not @plan.valid?
    @plan.group_id = 1
    @plan.datetime = nil
    assert_not @plan.valid?
  end
  
  test "should include user participate in plan" do
    assert @plan.has_user.include?(@Bob)
  end
  
  test "should be invalid when content is too long" do
    @plan.content = "a" * 256
    assert_not @plan.valid?
  end
  
end

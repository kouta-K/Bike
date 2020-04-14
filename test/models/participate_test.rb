require 'test_helper'

class ParticipateTest < ActiveSupport::TestCase
  def setup
    @participate = participates(:One)
    @plan = plans(:One)
    @Bob = users(:Bob)
  end
  
  test "should return user who participate in plan" do
    assert_equal @Bob, @participate.user
  end
  
  test "should return plan" do
    assert_equal @plan, @participate.plan
  end
end

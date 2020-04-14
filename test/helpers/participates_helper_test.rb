require "test_helper"

class ParticipatesHelperTest < ActionView::TestCase
    def setup
        @user = users(:Bob)
        @plan = plans(:One)
        @other_user = users(:Michael)
    end
    
    test "should be true when plan belongs_to user" do
        login_as(@user)
        assert participate_user?(@plan.has_user)
    end
    
    test "should be false when plan not belongs_to other_user" do
        login_as(@other_user)
        assert_not participate_user?(@plan.has_user)
    end
    
end
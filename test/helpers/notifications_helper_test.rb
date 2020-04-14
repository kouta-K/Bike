require "test_helper"

class NotificationsHelperTest < ActionView::TestCase
    def setup
        @Bob = users(:Bob)
        @Michael = users(:Michael)
    end
    
    test "return true when checked column is false" do
        login_as(@Bob)
        assert_equal true,  unchecked_notification?
    end 
    
    test "return false when checked column is true" do
        login_as(@Michael)
        assert_equal false,  unchecked_notification?
    end
end
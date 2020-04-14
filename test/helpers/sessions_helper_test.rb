require "test_helper"


class SessionsHelperTest < ActionView::TestCase
    def setup
        @user = users(:Bob)
    end
    test "current_user should return user when login as user" do
        assert current_user.nil?
        login(@user)
        assert login?
        assert_equal current_user, @user
    end
    
    test "current_user and session[:user_id] should retunr nil when logout as user" do
        login(@user)
        assert_not session[:user_id].nil?
        assert_not current_user.nil?
        logout
        assert session[:user_id].nil?
        assert current_user.nil?
    end
end
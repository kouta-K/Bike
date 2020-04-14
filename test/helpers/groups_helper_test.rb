require "test_helper"

class GroupsHelperTest < ActionView::TestCase
   def setup
       @group =  groups(:one)
       @user = users(:Bob)
       @other_user = users(:Michael)
   end
   
   test "should be true when login_user is admin_user" do
      login_as(@user)
      assert admin_user?(@group)
   end
   
   test "should be false when login_user is not admin_user" do
      login_as(@other_user)
      assert_not admin_user?(@group)
   end 
   
   test "should be true when user request group" do
      login_as(@other_user)
      assert send_request?(@group)
   end
   
   test "should be true when avtivate user" do
      login_as(@user)
      assert group_activate_member?(@group)
   end
   
   test "should be false when no activate user" do
      login_as(@other_user)
      assert_not group_activate_member?(@group)
   end 
   
   test "should return average age" do
      assert_equal (18 + 20)/2, average_age(@group)
   end
end
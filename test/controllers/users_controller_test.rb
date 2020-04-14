require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  test "should redirect login url when valid form" do
    assert_difference "User.count" do
      post users_path, params: { user: {
        name: "test", email: "success@co.jp",age: 18,password: "password",password_confirmation: "password" 
      }}
    end
    assert_redirected_to login_url
  end
  
  test "should render new when invalid form" do
    assert_no_difference "User.count" do
      post users_path, params: { user: {
        name: "test", email: "test@co.jp",password: "password",password_confirmation: "password1" 
      }}
    end
    assert_not session[:user_id]
    assert flash.any?
    assert_template "users/new"
  end
  

end

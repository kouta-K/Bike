require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "should redirect login url when valid form" do 
    get new_user_path
    assert_select "a[href=?]", login_path, text: "こちら"
    assert_difference "User.count" do
      post users_path, params: { user: {
        name: "test", email: "test123@co.jp", age: 18, password: "password",password_confirmation: "password" 
      }}
    end
    assert_redirected_to login_path
    follow_redirect!
  end
  
  test "should redirect new when invalid params" do
    get new_user_path
    assert_template "users/new"
    assert_no_difference "User.count" do
      post users_path,  params: {user: {
        name: "test",
        email: "",
        password: "",
        password_confirmation: ""
      }}
    end
    assert flash.any?
    assert_template "users/new"
  end 
end

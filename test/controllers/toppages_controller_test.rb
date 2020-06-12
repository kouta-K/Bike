require 'test_helper'

class ToppagesControllerTest < ActionDispatch::IntegrationTest
  test "should be return no loin toppage when user is not login" do
    get root_url
    assert session[:user_id].nil?
    assert_select "div#no-login-page"
  end
end

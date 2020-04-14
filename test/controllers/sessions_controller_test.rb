require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should be render new when invalid form" do
    post login_path, params: {session:{
                              email: "test@co.jp",
                              password: ""
    }}
    assert flash.any?
    assert_equal flash[:danger], "ログイン失敗"
    assert_template "sessions/new"
    assert_select "div.alert-danger"
  end
end

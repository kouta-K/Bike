require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  test "should be redicet login page when unlogin" do 
    get new_micropost_path
    assert_redirected_to login_path
    
    assert_no_difference "Micropost.count" do
      post microposts_path, params: {micropost: {
                            content: "hello"
      }}
    end
    assert_redirected_to login_path
  end

end

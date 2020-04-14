require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  def setup
    @favorite = favorites(:one)
  end
  
  test "should be invalid when user_id or micropost_id do not exist" do
    assert @favorite.valid?
    @favorite.user_id = nil
    assert_not @favorite.valid?
    @favorite.user_id = 1
    @favorite.micropost_id = nil
    assert_not @favorite.valid?
  end
end

require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @Bob = users(:Bob)
    @Michael = users(:Michael)
    @micropost = microposts(:one)
    @micropost2 = microposts(:two)
  end
  
  test "should count up when user favorite micrpost" do
    login_as(@Bob)
    assert current_user, @Bob
    get micropost_path(@micropost2)
    assert_difference "Favorite.count", 1 do
      post favorites_path, params: {favorite: {micropost_id: @micropost2.id}}
    end
  end
  
  test "should count down when user un favorite micropost" do
    login_as(@Michael)
    assert_difference "Favorite.count", -1 do
      delete favorite_path(current_user.favorites.find_by(micropost_id: @micropost.id))
    end
    
  end
  
  
end

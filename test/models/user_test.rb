require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "test", email: "testuser@co.jp",age: 18, password: "password", password_confirmation: "password")
    @Bob = users(:Bob)
    @Michael = users(:Michael)
    @Mike = users(:Mike)
    @micropost = microposts(:one)
    @group = groups(:one)
  end
  
  test "should be valid when valid user" do
    assert @user.valid?
  end
  
  test "should be invalid when email is too long and blank and not match regex" do
    @user.email = "a"* 256 + "@co.jp"
    assert_not @user.valid?
    @user.email = " "
    assert_not @user.valid?
    @user.email = "abcdefg"
    assert_not @user.valid?
  end
  
  test "should be invalid when name is too long and blank" do
    @user.name = "a" * 31
    assert_not @user.valid?
    @user.name = "  "
    assert_not @user.valid?
  end
  
  test "should be invalid password is deffrence from password_confirmation" do
    @user.password_confirmation = "password1"
    assert_not @user.valid?
  end
  
  test "should be invalid when age is smaller than 18 or type is invalid string" do
    @user.age = 17
    assert_not @user.valid?
    @user.age = "aa"
    assert_not @user.valid?
  end
  
  test "should be retutrn follow user" do
    assert @Bob.followings.include?(@Michael)
    assert_not @Bob.followings.include?(@Mike)
  end
  
  test "should be return follower user" do
    assert @Michael.followers.include?(@Bob)
    assert_not @Michael.followers.include?(@Mike)
  end
  
  test "should be plus one Relationship.count" do
    assert_difference "Relationship.count", 1 do
      @Bob.follow(@Mike)
    end
  end
  
  test "should be minus one Relationship.count" do
    assert_difference "Relationship.count", -1 do
      @Bob.unfollow(@Michael)
    end
  end
  
  
  test "should be return true when include user" do
    assert @Bob.following?(@Michael)
    assert_not @Bob.following?(@Mike)
  end
  
  test "should be true when correct token " do
    token = User.new_token
    digest = User.digest(token)
    @Bob.activation_digest = digest 
    assert @Bob.authenticated?(token)
  end
  
  test "should return favorite micropost" do
    assert @Michael.has_favorites.include?(@micropost)
  end
  
  test "should return user's micropost" do
    assert @Bob.microposts.include?(@micropost)
  end
  
  test "should return group user create" do
    assert @Bob.groups.include?(@group)
  end
end

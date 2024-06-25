require "test_helper"

class User::UserFollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_user_follows_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_user_follows_destroy_url
    assert_response :success
  end
end

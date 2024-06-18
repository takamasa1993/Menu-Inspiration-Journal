require "test_helper"

class Admin::IngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_ingredients_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_ingredients_show_url
    assert_response :success
  end
end

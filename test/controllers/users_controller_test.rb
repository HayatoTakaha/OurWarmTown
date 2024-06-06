require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get mypage" do
    get users_mypage_url
    assert_response :success
  end

  test "should get edit" do
    get users_edit_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

  test "should get update" do
    get users_update_url
    assert_response :success
  end

  test "should get destroy" do
    get users_destroy_url
    assert_response :success
  end

  test "should get liked_posts" do
    get users_liked_posts_url
    assert_response :success
  end

  test "should get search" do
    get users_search_url
    assert_response :success
  end

  test "should get search_results" do
    get users_search_results_url
    assert_response :success
  end

  test "should get guest_sign_in" do
    get users_guest_sign_in_url
    assert_response :success
  end
end

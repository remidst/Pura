require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get messages_new_url
    assert_response :success
  end

  test "should get create" do
    get messages_create_url
    assert_response :success
  end

  test "should get adit" do
    get messages_adit_url
    assert_response :success
  end

  test "should get update" do
    get messages_update_url
    assert_response :success
  end

  test "should get destroy" do
    get messages_destroy_url
    assert_response :success
  end

end

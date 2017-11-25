require 'test_helper'

class ReportingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get reportings_create_url
    assert_response :success
  end

  test "should get update" do
    get reportings_update_url
    assert_response :success
  end

  test "should get delete" do
    get reportings_delete_url
    assert_response :success
  end

end

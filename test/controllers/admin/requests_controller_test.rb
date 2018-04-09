require 'test_helper'

class Admin::RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_requests_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_requests_show_url
    assert_response :success
  end

  test "should get update" do
    get admin_requests_update_url
    assert_response :success
  end

end

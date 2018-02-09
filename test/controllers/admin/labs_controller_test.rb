require 'test_helper'

class Admin::LabsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_labs_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_labs_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_labs_create_url
    assert_response :success
  end

  test "should get show" do
    get admin_labs_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_labs_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_labs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_labs_destroy_url
    assert_response :success
  end

end

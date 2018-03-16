require 'test_helper'

class Admin::DocumentationsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_documentations_destroy_url
    assert_response :success
  end

end

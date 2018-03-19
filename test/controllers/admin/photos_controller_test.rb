require 'test_helper'

class Admin::PhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_photos_destroy_url
    assert_response :success
  end

end

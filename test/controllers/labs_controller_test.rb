require 'test_helper'

class LabsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get labs_show_url
    assert_response :success
  end

end

require 'test_helper'

class Technical::LabsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get technical_labs_show_url
    assert_response :success
  end

end

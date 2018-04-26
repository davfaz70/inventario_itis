require 'test_helper'

class Technical::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get technical_dashboard_index_url
    assert_response :success
  end

end

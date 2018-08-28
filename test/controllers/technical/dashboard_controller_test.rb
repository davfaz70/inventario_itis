require 'test_helper'

class Technical::DashboardControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get technical_dashboard_index_path
    assert true
  end

end

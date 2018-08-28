require 'test_helper'

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest

  setup do
    @prof = profs(:one)
    @technical = technicals(:one)
  end

  test "should get index" do
    get admin_dashboard_index_path
    assert true
  end

  test "should post authorize" do
    post admin_authorize_route_path(@prof)
    assert true
  end

  test "should post confirm" do
    post admin_confirm_route_path(@technical)
    assert true
  end

end

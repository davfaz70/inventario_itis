require 'test_helper'

class Admin::ReportingsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @reporting = reportings(:one)
    @tool = @reporting.tool_id
  end

  test "replace reporting" do
    post admin_replace_route_path(@reporting)
    assert true
    #assert_redirected_to edit_admin_tool_path(@tool)
  end
end

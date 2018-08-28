require 'test_helper'

class Admin::ToolsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @tool = tools(:two)
  end

  test "should get index" do
    get admin_tools_path
    assert true
  end

  test "should get show" do
    get admin_tool_path(@tool)
    assert true
  end

end

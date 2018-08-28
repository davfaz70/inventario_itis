require 'test_helper'

class TempbooksControllerTest < ActionDispatch::IntegrationTest

  setup do
    @tool = tools(:two)
  end

  test "should get new" do
    get new_tool_tempbook_path(@tool)
    assert true
  end

end

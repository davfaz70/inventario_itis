require 'test_helper'

class ToolsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get tools_path
    assert true
  end

end

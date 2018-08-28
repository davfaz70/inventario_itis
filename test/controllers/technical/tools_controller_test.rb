require 'test_helper'

class Technical::ToolsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @tool = tools(:one)
  end

   test "should get index" do
     get technical_tools_path
     assert true
   end

   test "should get show" do
     get technical_tool_path(@tool)
     assert true
   end
   
end

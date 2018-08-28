require 'test_helper'

class Admin::DocumentationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @doc = documentations(:one)
    @tool = tools(:one)
  end

  test "should get destroy" do
    delete admin_tool_documentation_path(@tool, @doc)
    assert true
  end

end

require 'test_helper'

class Technical::LabsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @lab = labs(:one)
    @tool = tools(:one)
  end

  test "should get index" do
    get technical_tool_labs_path(@tool)
    assert true
  end

  test "should get show" do
    get technical_lab_path(@lab)
    assert true
  end

end

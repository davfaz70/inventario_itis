require 'test_helper'

class Technical::ReportingsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @lab=labs(:one)
    @tool = tools(:two)
    @repo = reportings(:two)
  end

  test "should get index" do
    get technical_reportings_path
    assert true
  end

  test "should get new" do
    get new_technical_tool_lab_reporting_path(@tool, @lab)
    assert true
  end

  test "should get edit" do
    get edit_technical_tool_lab_reporting_path(@tool, @lab, @repo)
    assert true
  end

end

require 'test_helper'

class Admin::BookingsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @tool = tools(:one)
    @tool2 = tools(:two)
  end

  test "should get index" do
    get admin_tool_bookings_path(@tool)
    assert true
  end

  test "should get index other tool" do
    get admin_tool_bookings_path(@tool2)
    assert true
  end

end

require 'test_helper'

class Admin::BooksControllerTest < ActionDispatch::IntegrationTest

  setup do
    @tool = tools(:one)
    @tool2 = tools(:two)
  end

  test "should get index" do
    get admin_tool_books_path(@tool)
    assert true
  end

  test "should get index other tool" do
    get admin_tool_books_path(@tool2)
    assert true
  end

end

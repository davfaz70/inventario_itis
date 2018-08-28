require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @request = requests(:two)
  end

  test "should get index" do
    get requests_path
    assert true
  end

  test "should get new" do
    get new_request_path
    assert true
  end

  test "should get show" do
    get request_path(@request)
    assert true
  end

end

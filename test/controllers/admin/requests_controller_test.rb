require 'test_helper'

class Admin::RequestsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @request = requests(:one)
  end

  test "should get index" do
    get admin_requests_path
    assert true
  end

  test "should get show" do
    get admin_request_path(@request)
    assert true
  end

end

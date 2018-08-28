require 'test_helper'

class Technical::RequestsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @request = requests(:one)
  end

  test "should get index" do
    get  technical_requests_path
    assert true
  end

  test "should get new" do
    get new_technical_request_path
    assert true
  end
# to do:
#  test "should get edit" do
  #  get edit_technical_request_path(@request)
  #  assert true
#  end

  test "should get show" do
    get technical_request_path(@request)
    assert true
  end

end

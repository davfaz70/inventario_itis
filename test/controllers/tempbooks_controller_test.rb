require 'test_helper'

class TempbooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tempbooks_new_url
    assert_response :success
  end

  test "should get create" do
    get tempbooks_create_url
    assert_response :success
  end

end

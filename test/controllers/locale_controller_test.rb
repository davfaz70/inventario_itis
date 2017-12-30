require 'test_helper'

class LocaleControllerTest < ActionDispatch::IntegrationTest
  test "should get change_locale" do
    get locale_change_locale_url
    assert_response :success
  end

end

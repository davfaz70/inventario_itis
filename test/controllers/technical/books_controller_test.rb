require 'test_helper'

class Technical::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get technical_books_destroy_url
    assert_response :success
  end

end

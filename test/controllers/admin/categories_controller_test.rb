require 'test_helper'

class Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @category = categories(:one)
  end

  test "should get index" do
    get admin_categories_path
    assert true
  end

  test "should get new" do
    get new_admin_category_path
    assert true
  end

  test "should get show" do
    get admin_category_path(@category)
    assert true
  end

end

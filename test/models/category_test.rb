require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = Category.new(name:"categoria")
  end

  test "category valid" do
    assert @category.save
  end

  test "name validation" do
    @category.name = nil
    assert_not @category.save, "Category must have a name"
  end
end

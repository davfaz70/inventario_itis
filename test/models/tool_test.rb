require 'test_helper'

class ToolTest < ActiveSupport::TestCase
  fixtures :tools

  setup do
    @lab = labs(:one)
  end

  test "tool's labs" do
    tool = Tool.new
    tool.name = "Test"
    tool.description = "Tool must have one or more labs"
    tool.slug = "test"
    tool.identifier =  "Something"
    tool.quantity = 1
    assert_not tool.save, "Tool must have one or more labs"
  end

  test "tool quantity must be positive or zero" do
    tool = Tool.new(name: "testing", description: "See the failed test!", slug: "testing", identifier:"")
    tool.labs << @lab
    tool.quantity = -1
    assert tool.invalid?, "Quantity must be more or equal to 0"
  end

  test "tool identifier" do
    tool = Tool.new
    tool.name = "Test"
    tool.description = "Should not save more than one tool if this have an identifier"
    tool.slug = "test"
    tool.identifier = "Something"
    tool.quantity = 2
    tool.labs << @lab
    assert_not tool.save, "If the tool have identifier, the quantity of it must not be greater than one "
  end

end

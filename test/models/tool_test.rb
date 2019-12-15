require 'test_helper'

class ToolTest < ActiveSupport::TestCase
  fixtures :tools

  setup do
    @lab = labs(:one)
    @labtwo = labs(:two)
    @tool = Tool.new(name: "test", description: "test per i models", slug: "test", identifier: "qualcosa", quantity: 1)
    @tool.labs << @lab
  end

  test "tool save" do
    assert @tool.save
  end

  test "tool's labs" do
    @tool.labs.delete(@lab)
    assert_not @tool.save, "Tool must have one or more labs"
  end

  test "number labs" do
    @tool.labs << @labtwo
    assert_not @tool.save, "There is one tool, how can this tool stay in two labs?"
  end

  test "tool name" do
    @tool.name = nil
    assert_not @tool.save
  end

  test "tool description" do
    @tool.description = nil
    assert_not @tool.save
  end



end

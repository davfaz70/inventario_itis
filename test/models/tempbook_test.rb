require 'test_helper'

class TempbookTest < ActiveSupport::TestCase

  setup do
    @tool = tools(:one)
    @lab = labs(:one)
    @prof = profs(:one)
    @tempbook = Tempbook.new(goal:"Test", start_date:"Fri, 22 Jul 2050 08:40:00 CEST +02:00", end_date:"Fri, 22 Jul 2050 10:15:00 CEST +02:00", quantity: 1, tool_id: 1, lab_id: 1, prof_id: 298486374)
    @tempbook.prof = @prof
    @tempbook.lab = @lab
    @tempbook.tool = @tool
  end

  test "tempbook save" do
    assert @tempbook.save
  end

  test "goal" do
    @tempbook.goal = nil
    assert_not @tempbook.save
  end

  test "start_date presence" do
    @tempbook.start_date = nil
    assert_not @tempbook.save
  end

  test "end_date presence" do
    @tempbook.end_date = nil
    assert_not @tempbook.save
  end

  test "quantity presence" do
    @tempbook.quantity = nil
    assert_not @tempbook.save
  end

  test "tool" do
    @tempbook.tool_id = nil
    assert_not @tempbook.save, "Tempbook must have a tool"
  end

  test "prof" do
    @tempbook.prof_id = nil
    assert_not @tempbook.save, "Tempbook must have a prof"
  end

  test "lab" do
    @tempbook.lab_id = nil
    assert_not @tempbook.save
  end

  test "start_date after end_date" do
    @tempbook.start_date = "Fri, 22 Jul 2050 10:15:00 CEST +02:00"
    @tempbook.end_date = "Fri, 22 Jul 2050 08:40:00 CEST +02:00"
    assert_not @tempbook.save
  end

  test "quantity of tool" do
    @tempbook.quantity = 2
    assert_not @tempbook.save, "You can not book more tools than there are actually"
  end

  test "negative quantity" do
    @tempbook.quantity = -1
    assert_not @tempbook.save
  end
end

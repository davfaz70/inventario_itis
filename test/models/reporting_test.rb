require 'test_helper'

class ReportingTest < ActiveSupport::TestCase
  setup do
    @tool = tools(:two)
    @reporting = Reporting.new(description:"Questa è una segnalazione di esempio", quantity: 10, tool_id: 2, lab_id: 1, technical_id: 298486374)
    @reporting.tool = @tool
  end

  test "reporting valid" do
    assert @reporting.save
  end

  test "description validation" do
    @reporting.description = nil
    assert_not @reporting.save, "reporting must have a description"
  end

  test "quantity validation" do
    @reporting.quantity = nil
    assert_not @reporting.save, "reporting must have a quantity"
  end

  test "quantity tool validation" do
    @reporting.quantity = 30
    assert_not @reporting.save
  end

  test "lab validation" do
    @reporting.lab_id = nil
    assert_not @reporting.save, "reporting must have a lab"
  end

  test "technical validation" do
    @reporting.technical_id = nil
    assert_not @reporting.save, "reporting must have a technical"
  end
  
end

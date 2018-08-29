require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  setup do
    @request = Request.new(name: "Richiesta", description:"Richiesta esempio", quantity: 10, goal: "Vediamo se il test passa", technical_id: 298486374, approved:false, money:false, arrived:false)
  end

  test "request valid" do
    assert @request.save
  end

  test "description validation" do
    @request.description = nil
    assert_not @request.save, "request must have a description"
  end

  test "quantity validation" do
    @request.quantity = nil
    assert_not @request.save, "request must have a quantity"
  end

  test "quantity negative validation" do
    @request.quantity = -1
    assert_not @request.save, "request must have a positive quantity"
  end

  test "name validation" do
    @request.name = nil
    assert_not @request.save
  end

  test "goal validation" do
    @request.goal = nil
    assert_not @request.save, "request must have a goal"
  end

  test "money validation" do
    @request.approved = false
    @request.money = true
    assert_not @request.save
  end

  test "arrived validation" do
    @request.approved = false
    @request.arrived = true
    assert_not @request.save
  end

  test "arrived validation with money" do
    @request.money = false
    @request.arrived = true
    assert_not @request.save
  end

end

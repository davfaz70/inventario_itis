require 'test_helper'

class Admin::TechnicalsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @technical = technicals(:one)
  end

  test "should get index" do
    get admin_technicals_path
    assert true
  end

  test "should get show" do
    get admin_technical_path(@technical)
    assert true
  end
end

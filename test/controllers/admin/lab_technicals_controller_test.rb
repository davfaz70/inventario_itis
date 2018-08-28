require 'test_helper'

class Admin::LabTechnicalsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @lab = labs(:one)
    @technical = technicals(:one)
  end

  test "should get new from lab" do
    get new_admin_lab_lab_technical_path(@lab)
    assert true
  end

  test "should get new from technical" do
    get new_admin_technical_lab_technical_path(@technical)
    assert true
  end
end

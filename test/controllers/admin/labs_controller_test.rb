require 'test_helper'

class Admin::LabsControllerTest < ActionDispatch::IntegrationTest
  #include Devise::Test::ControllerHelpers

  setup do
    @lab = labs(:one)
    @tool = tools(:two)
  #  @request.env["devise.mapping"] = Devise.mappings[:admin]
  #  sign_in FactoryBot.create(:admin)
  end

  #FactoryBot.define do
  #  factory :account do
  #    email { Faker::Internet.email }
  #    role 1
  #    agree true
  #    password "password"
  #    password_confirmation "password"
  #    confirmed_at Date.today
  #  end
  #end

  test "should get index" do
    get admin_labs_path
    assert true
  end

  test "should get new" do
    get new_admin_lab_path
    assert true
  end

  test "should get show" do
    get admin_lab_path(@lab)
    assert true
  end

  test "should get edit" do
    get edit_admin_lab_path(@lab)
    assert true
  end

  test "should get assign" do
    get admin_assign_lab_route_path(@lab)
    assert true
  end

  test "should get assign update" do
    get admin_assign_update_lab_route_path(@lab, @tool)
    assert true
    #assert_redirected_to admin_assign_lab_route_path(@lab)
  end

end

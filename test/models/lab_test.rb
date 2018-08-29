require 'test_helper'

class LabTest < ActiveSupport::TestCase
  setup do
    @lab = Lab.new(name:"Laboratorio", subject: "Test")
  end

  test "lab valid" do
    assert @lab.save
  end

  test "name validation" do
    @lab.name = nil
    assert_not @lab.save, "lab must have a name"
  end

  test "subject validation" do
    @lab.subject = nil
    assert_not @lab.save
  end
end

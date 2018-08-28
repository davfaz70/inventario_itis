require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @tool = tools(:two)
    @post = posts(:one)
  end

   test "should get edit" do
     get edit_tool_post_path(@tool, @post)
     assert true
   end
   
end

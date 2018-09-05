require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @tool = tools(:one)
    @prof = profs(:one)
    @post = Post.new(body:"Questo è un post di esempio", tool_id: 1, prof_id: 298486374)
    @post.tool = @tool
    @post.prof = @prof
  end

  test "post valid" do
    assert @post.save
  end

  test "body validation" do
    @post.body = nil
    assert_not @post.save, "post must have a body"
  end
end

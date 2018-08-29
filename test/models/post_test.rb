require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = Post.new(body:"Questo è un post di esempio")
  end

  test "post valid" do
    assert @post.save
  end

  test "body validation" do
    @post.body = nil
    assert_not @post.save, "post must have a body"
  end
end

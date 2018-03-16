class PostsController < ApplicationController
  before_action :authenticate_prof!
  before_action :authorized_prof
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_tool, only: [:create, :edit, :update, :destroy]

  def create
    @post = @tool.posts.build(post_params)
    @post.prof_id = current_prof.id
    if @post.save
      flash[:primary] = t('.created')
      redirect_to tool_path(@tool)
    else
      flash[:danger] = t('.oops')
      redirect_to tool_path(@tool)
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      flash[:success]= t('.updated')
      redirect_to tool_path(@tool)
    else
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:success]= t('.delete')
      redirect_to tool_path(@tool)
    else
      redirect_to tool_path(@tool)
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_tool
    @tool = Tool.friendly.find(params[:tool_id])
  end

  def post_params
    params.require(:post).permit(:prof_id, :tool_id, :body)
  end
end

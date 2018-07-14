class ToolsController < ApplicationController
  before_action :set_tool, only: [:show]

  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    lab = params[:lab]
    category = params[:category]
    @q = Tool.with_translations(I18n.locale).ransack(q_param)
    @tools = @q.result(distinct: true).page(page).per(per_page).includes(:categories, :labs)

    @categories = Category.all
    @labs = Lab.all
  end

  def show
    @posts = @tool.posts
    @tempbook = @tool.tempbooks.build
  end

  private

  def set_tool
    @tool = Tool.friendly.find(params[:id])
  end

end

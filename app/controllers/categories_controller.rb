class CategoriesController < ApplicationController

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category
    else
      render json: @category.errors.full_messages
    end
  end

  def show
    @category = Category.friendly.find(params[:id])

    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    @q = @category.tools.with_translations(I18n.locale).ransack(q_param)
    @tools = @q.result(distinct: true).page(page).per(per_page)

    @categories = Category.all
    @labs = Lab.all
  end

  private
  
  def category_params
    params.require(:category).permit(:name)
  end

end

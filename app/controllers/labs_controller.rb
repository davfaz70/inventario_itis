class LabsController < ApplicationController
  def show
    @lab = Lab.friendly.find(params[:id])

    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    @q = @lab.tools.with_translations(I18n.locale).ransack(q_param)
    @tools = @q.result(distinct: true).page(page).per(per_page)

    @labs = Lab.all
    @categories = Category.all
  end
end

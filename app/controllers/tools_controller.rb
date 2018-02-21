class ToolsController < ApplicationController
  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    @q = Tool.with_translations(I18n.locale).ransack(q_param)
    @tools = @q.result(distinct: true).page(page).per(per_page)
  end

end

class Technical::ToolsController < Technical::TechnicalController
  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    lab = params[:lab]
    category = params[:category]
    
    @q = Tool.with_translations(I18n.locale).ransack(q_param)
    @tools = @q.result(distinct: true).page(page).per(per_page).includes(:categories, :labs)

    @categories = Category.all
    @labs = current_technical.labs
  end

  def show
    @tool = Tool.friendly.find(params[:id])
  end
end

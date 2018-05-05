class Technical::ToolsController < Technical::TechnicalController
  def index
    @labs = current_technical.lab_technicals.select(:lab_id).distinct
  end

  def show
    @tool = Tool.friendly.find(params[:id])
  end
end

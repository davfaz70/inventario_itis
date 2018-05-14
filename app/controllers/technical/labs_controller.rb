class Technical::LabsController < Technical::TechnicalController

  def index
    @labs = current_technical.labs.distinct
    @tool = Tool.friendly.find(params[:tool_id])
  end

  def show

  end

end

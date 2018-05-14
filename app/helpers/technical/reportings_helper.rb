module Technical::ReportingsHelper
  def tool_lab
    @tool = Tool.friendly.find(params[:tool_id])
    @lab = Lab.friendly.find(params[:lab_id])
  end
end

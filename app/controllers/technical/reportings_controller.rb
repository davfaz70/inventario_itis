class Technical::ReportingsController < Technical::TechnicalController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = current_technical.reportings
  end

  def new
    @tool = Tool.friendly.find(params[:tool_id])
    @lab = Lab.friendly.find(params[:lab_id])
    @report = Reporting.new
  end

  def create
    @report = Reporting.new(report_params)
    if @report.save
      flash[:primary] = t('.created')
      redirect_to technical_reportings_path
    else
      flash[:danger] = "Oooops"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @report.update(report_params)
      redirect_to technical_tool_report_path(@report.tool, @report)
    else
      render 'edit'
    end
  end

  def destroy
    if @report.destroy
      redirect_to technical_tool_reports_path
    else
      flash[:danger] = "Oooops"
    end
  end

  private

  def report_params
    params.require(:reporting).permit(:tool_id, :lab_id, :technical_id, :description, :quantity)
  end

  def set_report
    @report = Reporting.find(params[:id])
  end

end

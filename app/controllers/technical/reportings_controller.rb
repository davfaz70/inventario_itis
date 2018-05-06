class Technical::ReportingsController < Technical::TechnicalController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reportings = current_technical.reportings
  end

  def new
    @tool = Tool.friendly.find(params[:tool_id])
    @lab = Lab.friendly.find(params[:lab_id])
    @reporting = Reporting.new
  end

  def create
    @reporting = Reporting.new(report_params)
    if @reporting.save
      AdminMailer.new_reporting(@reporting).deliver_later
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
    if @reporting.update(report_params)
      redirect_to technical_tool_report_path(@reporting.tool, @reporting)
    else
      render 'edit'
    end
  end

  def destroy
    if @reporting.destroy
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
    @reporting = Reporting.find(params[:id])
  end

end

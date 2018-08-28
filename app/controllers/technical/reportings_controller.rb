class Technical::ReportingsController < Technical::TechnicalController
  before_action :set_reporting, only: [:show, :edit, :update, :destroy]
  before_action :set_variables_and_control, only: [:new, :edit]

  def index
    @reportings = current_technical.reportings
  end

  def new
    @reporting = Reporting.new
  end

  def create
    @reporting = Reporting.new(reporting_params)
    if @reporting.save
      AdminMailer.new_reporting(@reporting).deliver_later
      flash[:primary] = t('.created')
      redirect_to technical_reportings_path
    else
      render action: :new
    end
  end

  def show
  end

  def edit

  end

  def update
    if @reporting.update(reporting_params)
      redirect_to technical_reportings_path
    else
      render 'edit'
    end
  end

  def destroy
    if @reporting.destroy
      flash[:primary] = t('.deleted')
      redirect_to technical_reportings_path
    else
      flash[:danger] = "Oooops"
      redirect_to technical_reportings_path
    end
  end

  private

  def reporting_params
    params.require(:reporting).permit(:tool_id, :lab_id, :technical_id, :description, :quantity)
  end

  def set_reporting
    @reporting = Reporting.find(params[:id])
  end

  def set_variables_and_control
    @tool = Tool.friendly.find(params[:tool_id])
    @lab = Lab.friendly.find(params[:lab_id])
    if current_technical.labs.include?(@lab)
      if current_technical.lab_technicals.where("lab_id=?", @lab.id).first.end_date != nil
        redirect_back(fallback_location:  technical_reportings_path)
        flash[:danger] = t('.notyourlab')
      end
    else
      redirect_back(fallback_location:  technical_reportings_path)
      flash[:danger] = t('.notyourlab')
    end
  end

end

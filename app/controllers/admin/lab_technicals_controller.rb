class Admin::LabTechnicalsController < Admin::AdminController

  def new
    @relation = LabTechnical.new
    @technical = Technical.find(params[:technical_id])
  end

  def create
    @relation = LabTechnical.new(lab_technical_params)
    if @relation.save
      flash[:success] = "Successfully created"
      redirect_to admin_technicals_path
    else
      flash[:danger] = "Oooops"
      redirect_to admin_technicals_path
    end
  end

  private

  def lab_technical_params
    params.require(:lab_technical).permit(:lab_id, :technical_id, :start_date, :end_date)
  end

end

class Admin::LabTechnicalsController < Admin::AdminController
  before_action :set_relation, only: [:edit, :update, :destroy]

  def new
    @relation = LabTechnical.new
    if params[:technical_id].present?
      @resource = Technical.find(params[:technical_id])
    else
      @resource = Lab.friendly.find(params[:lab_id])
    end
  end

  def create
    @relation = LabTechnical.new(lab_technical_params)
    if @relation.save
      flash[:success] = "Successfully created"
      redirect_to admin_technicals_path
    else
      flash[:danger] = @relation.errors.full_messages
      redirect_back(fallback_location:  admin_dashboard_index_path)
    end
  end

  def edit
    if params[:technical_id].present?
      @resource = Technical.find(params[:technical_id])
    else
      @resource = Lab.friendly.find(params[:lab_id])
    end
  end

  def update
    if @relation.update(lab_technical_params)
      flash[:success] = "Successfully updated"
      redirect_to admin_technicals_path
    else
      flash[:danger] = @relation.errors.full_messages
      redirect_back(fallback_location:  admin_dashboard_index_path)
    end
  end

  def destroy
    if @relation.destroy
      flash[:success]= t('.delete')
      redirect_back(fallback_location:  admin_dashboard_index_path)
    else
      redirect_back(fallback_location:  admin_dashboard_index_path)
    end
  end

  private

  def set_relation
    @relation = LabTechnical.find(params[:id])
  end

  def lab_technical_params
    params.require(:lab_technical).permit(:lab_id, :technical_id, :start_date, :end_date)
  end

end

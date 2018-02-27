class Admin::DashboardController < Admin::AdminController

  def index
    @profs = Prof.where(:authorized => false)
  end

  def authorize
    @prof = Prof.find(params[:id])
    @prof.authorized = true
    if @prof.save
      flash[:success]="ok"
      redirect_to admin_dashboard_index_path
    else
      flash[:danger]="ko"
      redirect_to admin_dashboard_index_path
    end
  end


end

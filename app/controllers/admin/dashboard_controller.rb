class Admin::DashboardController < Admin::AdminController

  def index
    @profs = Prof.all
  end

  def authorize
    @prof = Prof.find(params[:id])
    if @prof.authorized == false
      @prof.authorized = true
    else
      @prof.authorized =false
    end

    if @prof.save
      if @prof.authorized == true
        ProfMailer.authorized(@prof).deliver_later
      else
        ProfMailer.unauthorized(@prof).deliver_later
      end
      flash[:success]="ok"
      redirect_back(fallback_location:  admin_dashboard_index_path)
    else
      flash[:danger]="ko"
      redirect_back(fallback_location:  admin_dashboard_index_path)
    end
  end


end

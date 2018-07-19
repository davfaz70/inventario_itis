class Admin::DashboardController < Admin::AdminController

  #for more information about current_admin.role and request see controllers/admin/request_controller.rb

  def index
    @profs = Prof.where("confirmed_at IS NOT NULL")
    if current_admin.role == 0
      @requests = Request.where("approved = 'f'")
    elsif current_admin.role == 1
      @requests = Request.where("approved = 't' AND money = 'f'")
    else
      @requests = Request.where("approved = 't' AND money ='t' ")
    end
    @bookings = Book.where("confirmed = 'f'")
    @reportings = Reporting.all

    @newprofs = Prof.where("authorized = 'f' AND confirmed_at IS NOT NULL").count
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

  def confirm
    @technical = Technical.find(params[:id])
    if @technical.authorized == false
      @technical.authorized = true
    else
      @technical.authorized = false
    end

    if @technical.save
      if @technical.authorized == true
        TechnicalMailer.authorized(@technical).deliver_later
      else
        TechnicalMailer.unauthorized(@technical).deliver_later
      end
      flash[:success]="ok"
      redirect_back(fallback_location:  admin_dashboard_index_path)
    else
      flash[:danger]="ko"
      redirect_back(fallback_location:  admin_dashboard_index_path)
    end
  end


  def deleteprof
    @prof = Prof.find(params[:id])
    ProfMailer.destroyed(@prof).deliver_now
    @prof.destroy
    redirect_back(fallback_location:  admin_dashboard_index_path)
  end


end

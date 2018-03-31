class Admin::DocumentationsController < Admin::AdminController
  def destroy
    @document = Documentation.find(params[:id])
    if @document.destroy
      redirect_back(fallback_location:  admin_dashboard_index_path)
    else
      flash[:danger] = "Oooops"
      redirect_back(fallback_location:  admin_dashboard_index_path)
    end
  end
end

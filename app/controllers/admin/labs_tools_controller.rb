class Admin::LabsToolsController < Admin::AdminController
  def destroy
    @document = LabsTool.find(params[:id])
    if @document.destroy
      redirect_back(fallback_location:  admin_dashboard_index_path)
    else
      flash[:danger] = "Oooops"
      redirect_back(fallback_location:  admin_dashboard_index_path)
    end
  end
end

class Admin::PhotosController < Admin::AdminController
  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:success] = "Successfully deleted"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Oooops"
      redirect_back(fallback_location: root_path)
    end
  end
end

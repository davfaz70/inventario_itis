class Admin::DocumentationsController < ApplicationController
  def destroy
    @document = Documentation.find(params[:id])
    if @document.destroy
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Oooops"
      redirect_back(fallback_location: root_path)
    end
  end
end

class RequestsController < ApplicationController
  before_action :authenticate_prof!
  before_action :authorized_prof
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      flash[:primary] = t('.created')
      redirect_to tools_path
    else
      flash[:danger] = "Oooops"
      redirect_to tools_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:photo, :name, :description, :quantity, :goal, :prof_id, :technical_id, {photos_attributes: [:id, :picture, :tool_id, :request_id, :_destroy]}, {documentations_attributes: [:id, :name, :file, :tool_id, :request_id, :_destroy]}, { category_ids:[]})
  end

end

class RequestsController < ApplicationController
  before_action :authenticate_prof!
  before_action :authorized_prof
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      AdminMailer.new_request(@request).deliver_later
      flash[:primary] = t('.created')
      redirect_to tools_path
    else
      render "new"
    end
  end

  def index
    @notapproved = current_prof.requests.where("approved = 'f'")
    @approved = current_prof.requests.where("approved = 't' AND money = 'f'")
    @money = current_prof.requests.where("money = 't'")
  end

  def show
    @request = Request.find(params[:id])
  end

  private

  def request_params
    params.require(:request).permit(:photo, :name, :description, :quantity, :goal, :prof_id, :technical_id, {photos_attributes: [:id, :picture, :tool_id, :request_id, :_destroy]}, {documentations_attributes: [:id, :name, :file, :tool_id, :request_id, :_destroy]}, { category_ids:[]})
  end

end

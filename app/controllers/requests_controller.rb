class RequestsController < ApplicationController
  before_action :authenticate_prof!
  before_action :authorized_prof

  #In this controller, a request can be created by one prof, the entity request can be created by prof and technicals, for technicals the methods are in app/controllers/technical/requests_controller.rb

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      AdminMailer.new_request(@request).deliver_later #this email notify at the admin that a new request was created
      flash[:primary] = t('.created')
      redirect_to tools_path
    else
      render "new"
    end
  end

  def index
    # the requests have three fields, approved, money and arrived
    # for more information how it work see app/controllers/admin/request_controller.rb
    
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

class Admin::RequestsController < Admin::AdminController
  before_action :set_request, only: [:show, :update, :destroy]
  def index
    if current_admin.role == 0
      @requests = Request.where("approved = 'f'")
    elsif current_admin.role == 1
      @requests = Request.where("approved = 't' AND money = 'f'")
    else
      @requests = Request.where("approved = 't' AND money = 't' AND arrived = 'f'")
    end
  end

  def show
    if @request.prof.present?
      @subject = @request.prof
    else
      @subject = @request.technical
    end
  end

  def update
    if @request.update(request_params)
      if @request.arrived == true
        @tool = Tool.new
        @tool.photo = @request.photo
        @tool.name = @request.name
        @tool.description = @request.description
        @tool.quantity = @request.quantity
        if @tool.save
          @request.photos.each do |photo|
            @tool.photos << photo
          end
          @request.documentations.each do |document|
            @tool.documentations << document
          end
          @request.categories.each do |category|
            @tool.categories << category
          end
          @request.destroy
          flash[:success]= t('.updated')
          redirect_to edit_admin_tool_path(@tool)
        else
          flash[:danger]= 'Oooops'
          redirect_to admin_request_path(@request)
        end
      else
        flash[:success]= t('.updated')
        redirect_to admin_request_path(@request)
      end
    else
      render 'show'
    end
  end

  def destroy
    @request.destroy
    redirect_to admin_requests_path
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end


  def request_params
    params.require(:request).permit(:name)
  end
end

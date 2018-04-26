class Technical::RequestsController < Technical::TechnicalController

  def index
    @requests = current_technical.requests.all
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      flash[:primary] = t('.created')
      redirect_to technical_requests_path
    else
      flash[:danger] = "Oooops"
      render 'new'
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  private

  def request_params
    params.require(:request).permit(:photo, :name, :description, :quantity, :goal, :prof_id, :technical_id, {photos_attributes: [:id, :picture, :tool_id, :request_id, :_destroy]}, {documentations_attributes: [:id, :name, :file, :tool_id, :request_id, :_destroy]}, { category_ids:[]})
  end

end

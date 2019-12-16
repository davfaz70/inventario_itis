class Admin::RequestsController < Admin::AdminController
  before_action :set_request, only: [:show, :update, :destroy]

  # there are three types of admins:
  # the role 0 = headmaster, he can approve or delete a new request, so he see only the requests that are not approved
  # the role 1 = dsga, he check if the school have enough money for an approved request, if yes, he order the tool in the request, if not, he reject it, so he see only the requests that are approved
  # the role 2 = ata, when a new tool arrive, he insert it in this system, if the tool was request by someone, he click on button and the tool is automatically created, so he see only the requests that are ordered

  def index
    if current_admin.role == 0
      @requests = Request.where("approved = 'f'")
    elsif current_admin.role == 1
      @requests = Request.where("approved = 't' AND money = 'f'")
    else
      @requests = Request.where("approved = 't' AND money = 't'")
    end
  end

  # a request must made by one prof OR one technical
  def show
    if @request.prof.present?
      @subject = @request.prof
    else
      @subject = @request.technical
    end
  end

  #when an admin click on button, he update the request, the update depends on the request's state

  def update
    if @request.update(request_params)
      if @request.approved == true && @request.money == false
        AdminMailer.request_approved(@request).deliver_later #this email notify at the dsga that a new request was approved
        if @request.prof.present?
          ProfMailer.request_approved(@request.prof, @request).deliver_later #if the request was made by a prof, this email will notify at the prof that his request was approved
        else
          TechnicalMailer.request_approved(@request.technical, @request).deliver_later
        end
      elsif @request.money == true && @request.arrived == false
        AdminMailer.request_money(@request).deliver_later #this email notify at the ata that a new request tool was ordered
        if @request.prof.present?
          ProfMailer.request_money(@request.prof, @request).deliver_later
        else
          TechnicalMailer.request_money(@request.technical, @request).deliver_later
        end
      end
      if @request.arrived == true
        @tool = Tool.new
        @tool.name = @request.name
        @tool.description = @request.description
        if @tool.save
          @request.photos.each do |photo|
            @photo = @tool.photos.build
            @photo.picture = photo.picture
            @photo.save
          end
          @request.documentations.each do |document|
            @document = @tool.documentations.build
            @document.name = document.name
            @document.file = document.file
            @document.save
          end
          @request.categories.each do |category|
            @tool.categories << category
          end
          if @request.prof.present?
            ProfMailer.tool_arrived(@request.prof, @tool).deliver_now
          else
            TechnicalMailer.tool_arrived(@request.technical, @tool).deliver_now
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
        redirect_to admin_dashboard_index_path
      end
    else
      render 'show'
    end
  end

  def destroy
    if current_admin.role == 0
      if @request.prof.present?
        ProfMailer.request_not_approved(@request.prof, @request).deliver_now
      else
        TechnicalMailer.request_not_approved(@request.technical, @request).deliver_now
      end
    elsif current_admin.role == 1
      if @request.prof.present?
        ProfMailer.request_not_money(@request.prof, @request).deliver_now
      else
        TechnicalMailer.request_not_money(@request.technical, @request).deliver_now
      end
    elsif current_admin.role == 2
      flash[:danger] = t('.cannot')
      redirect_to admin_dashboard_index_path
    end
    @request.destroy
    flash[:success]= t('.deleted')
    redirect_to admin_dashboard_index_path
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end


  def request_params
    params.require(:request).permit(:name, :approved, :money, :arrived, :description, :quantity)
  end
end

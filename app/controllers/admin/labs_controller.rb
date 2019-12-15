class Admin::LabsController < Admin::AdminController
  before_action :set_lab, only: [:show, :edit, :update, :destroy, :assign, :assign_update]

  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    @q = Lab.order(:id).ransack(q_param)
    @labs = @q.result(distinct: true).page(page).per(per_page)
  end

  def new
    @lab = Lab.new
  end

  def create
    @lab = Lab.new(lab_params)
    if @lab.save
      flash[:success]= t('.created')
      redirect_to admin_labs_path
    else
      render 'new'
    end
  end

  def show
  end

  def assign

    @lab_tool = LabsTool.new
  end

  def edit_tool
  end

  def destroy_tool
  end

  def assign_update
      @lab_tool = LabsTool.new(labs_tool_params)
      if @lab_tool.save
        redirect_to admin_lab_path
      else
        render 'assign_tool'
      end
  end


  def edit

  end

  def update
    if @lab.update(lab_params)
      flash[:success]= t('.edited')
      redirect_to admin_labs_path
    else
      render 'edit'
    end
  end

  def destroy
    if @lab.destroy
      flash[:success]= t('.delete')
      redirect_to admin_labs_path
    else
      redirect_to admin_labs_path
    end
  end

  private

  def set_lab
    @lab = Lab.friendly.find(params[:id])
  end

  def lab_params
    params.require(:lab).permit(:name, :subject, { tool_ids:[]})
  end

  def labs_tool_params
    params.require(:labs_tool).permit(:tool_id, :lab_id, :quantity)
  end
end

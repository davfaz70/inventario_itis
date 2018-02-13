class Admin::LabsController < Admin::AdminController
  before_action :set_lab, only: [:show, :edit, :update, :destroy, :choose, :assign, :assign_update]

  def index
    @labs = Lab.order(:name).page
    params[:page]
  end

  def new
    @lab = Lab.new
  end

  def create
    @lab = Lab.new(lab_params)
    if @lab.save
      redirect_to admin_labs_path
    else
      render 'new'
    end
  end

  def choose
  end

  def show
  end

  def assign
    @q = Tool.ransack(params[:q])
    @tools = @q.result(distinct: true)
  end

  def assign_update
      @tool = Tool.friendly.find(params[:tool])
      if @lab.tools.include?(@tool)
        @lab.tools.delete(@tool)
        redirect_to admin_assign_lab_route_path(@lab)
      else
        @lab.tools << @tool
        redirect_to admin_assign_lab_route_path(@lab)
      end
  end


  def edit

  end

  def update
    if @lab.update(lab_params)
      redirect_to admin_labs_path
    else
      render 'edit'
    end
  end

  def destroy
    @lab.destroy
    redirect_to admin_labs_path
  end

  private

  def set_lab
    @lab = Lab.friendly.find(params[:id])
  end

  def lab_params
    params.require(:lab).permit(:name, :subject, { tool_ids:[]})
  end
end

class Admin::ToolsController < Admin::AdminController
  before_action :set_tool, only: [:edit, :destroy, :update, :choose, :prenotate]
  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    @o = Tool.search(q_param)
    @tools = @o.result(distinct: true).page(page).per(per_page)
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      redirect_to admin_tools_path
    else
      render 'new'
    end
  end

  def show
  end

  def choose
  end

  def prenotate

  end

  def edit
  end

  def update
    if @tool.update(tool_params)
      redirect_to admin_tools_path
    else
      render 'edit'
    end
  end

  def destroy
    @tool.destroy
    redirect_to admin_tools_path
  end

  private

  def set_tool
    @tool = Tool.friendly.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:photo, :name, :description, :days, :quantity)
  end
end

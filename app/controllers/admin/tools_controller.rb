class Admin::ToolsController < Admin::AdminController
  before_action :set_tool, only: [:edit, :destroy, :update, :choose, :show]
  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    @q = Tool.with_translations(I18n.locale).ransack(q_param)
    @tools = @q.result(distinct: true).page(page).per(per_page)

    @categories = Category.all
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      flash[:success]= t('.created')
      redirect_to admin_tool_path(@tool)
    else
      #@tool.errors.full_messages.each do |message|
      #  flash[:danger] = message
      #end
      #redirect_to new_admin_tool_path
      render 'new'
    end
  end

  def show
    @bookings = @tool.bookings.where('end_date >= ? AND confirmed = ?', Time.now, false) #for more info about this job see jobs/admin/checking.rb
    @quantity = 0
    for lab in @tool.labs_tools
      @quantity += lab.quantity
    end
  end

  def choose
  end

  def edit

  end

  def update
    if @tool.update(tool_params)
      flash[:success]= t('.edited')
      redirect_to admin_tool_path(@tool)
    else
      render 'edit'
    end
  end

  def destroy
    if @tool.destroy
      flash[:success]= t('.delete')
      redirect_to admin_tools_path
    else
      redirect_to admin_tools_path
    end
  end

  private

  def set_tool
    @tool = Tool.friendly.find(params[:id])
  end


  def tool_params
    params.require(:tool).permit(:name, :description, :identifier, {photos_attributes: [:id, :picture, :tool_id, :_destroy]}, {documentations_attributes: [:id, :name, :file, :tool_id, :_destroy]}, {labs_tools_attributes: [:id, :lab_id, :tool_id, :quantity, { lab_ids: []}, :_destroy]}, { lab_ids: []}, { category_ids: []})
  end
end

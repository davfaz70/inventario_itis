class Admin::ToolsController < Admin::AdminController
  before_action :set_tool, only: [:edit, :destroy, :update, :choose, :show]
  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    @o = Tool.with_translations(I18n.locale).ransack(q_param)
    @tools = @o.result(distinct: true).page(page).per(per_page)
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      flash[:success]= t('.created')
      redirect_to admin_tools_path
    else
      render 'new'
    end
  end

  def show
    @bookings = @tool.books
  end

  def choose
  end

  def edit

  end

  def update
    if @tool.update(tool_params)
      if @tool.books.where('end_date >= ?', Time.now).exists?
        @job = Delayed::Job.enqueue Admin::Checking.new(@tool, @tool.books.where('end_date >= ?', Time.now).count)
      end
      flash[:success]= t('.edited')
      redirect_to admin_tools_path
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
    params.require(:tool).permit(:photo, :name, :description, :identifier, :quantity, { lab_ids:[]}, { category_ids:[]})
  end
end

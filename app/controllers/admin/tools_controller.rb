class Admin::ToolsController < Admin::AdminController
  before_action :set_tool, only: [:edit, :destroy, :update, :choose, :prenotate, :show]
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

  end

  def choose
  end

  def prenotate

  end

  def edit
  #  @job = Delayed::Job.enqueue ChekingJob.new
  end

  def update
    if @tool.update(tool_params)
      if @tool.books.where('end_date >= ?', Time.now).count > 0
        cheking
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

  def cheking
    #users = User.first(100)
  #  @job = Delayed::Job.enqueue ::ChekingJob.new(@tool, @tool.books.where('end_date >= ?', Time.now).count)
  @book1 = @tool.books.where('end_date >= ?', Time.now).order(created_at: :desc)
  @book1.each do |booking|
    cont = 0
    @tool.books.where('end_date >= ?', Time.now).order(created_at: :desc).each do |b|
      if b.id != booking.id
        if booking.start_date >= b.start_date && booking.start_date <= b.end_date
          cont = cont + b.quantity
        elsif booking.end_date >= b.start_date && booking.end_date <= b.end_date
          cont = cont + b.quantity
        elsif b.start_date >= booking.start_date && b.start_date <= booking.end_date
          cont = cont + b.quantity
        end
      end
    end
    if cont >= @tool.quantity
#send_email_to_booking.prof_email
      booking.destroy
    end
  end
  end

  def set_tool
    @tool = Tool.friendly.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:photo, :name, :description, :identifier, :quantity, { lab_ids:[]}, { category_ids:[]})
  end
end

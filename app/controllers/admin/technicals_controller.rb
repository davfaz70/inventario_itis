class Admin::TechnicalsController < Admin::AdminController
  before_action :set_technical, only: [:show, :edit, :update, :destroy]

  def index
    q_param = params[:q]
    page = params[:page]
    per_page = params[:per_page]
    @q = Technical.order(:id).ransack(q_param)
    @technicals = @q.result(distinct: true).page(page).per(per_page)
  end

  def new
    @technical = Technical.new
  end

  def create
    @technical = Technical.new(technical_params)
    if @technical.save
      flash[:success]= t('.created')
      redirect_to admin_technicals_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit

  end

  def update
    if @technical.update(technical_params)
      flash[:success]= t('.edited')
      redirect_to admin_technicals_path
    else
      render 'edit'
    end
  end

  def destroy
    if @technical.destroy
      flash[:success]= t('.delete')
      redirect_to admin_technicals_path
    else
      redirect_to admin_technicals_path
    end
  end

  private

  def set_technical
    @technical = Technical.find(params[:id])
  end

  def technical_params
    params.require(:technical).permit(:name, :surname, :email, { lab_ids:[]})
  end

end

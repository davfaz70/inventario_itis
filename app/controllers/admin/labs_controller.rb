class Admin::LabsController < Admin::AdminController
  before_action :set_lab, only: [:show, :edit, :update, :destroy, :choose]

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
    params.require(:lab).permit(:name, :subject)
  end
end

class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]


  def index
    @categories = Category.all
  end




  def new
    @category = Category.new
  end


  def edit
  end

  def show
  end


  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category 
    else
      render 'new'
    end
  end


  def update
    if @category.update(category_params)
      flash[:success]= t('.edited')
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end

  # DELETE /professions/1
  # DELETE /professions/1.json
  def destroy
    if @category.destroy
      flash[:success]= t('.delete')
      redirect_to admin_categories_path
    else
      redirect_to admin_categories_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end

end

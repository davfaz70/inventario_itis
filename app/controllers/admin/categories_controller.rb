class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy]


  def index
    @q = Category.ransack(params[:q])
    @categories= @q.result(distinct: true)
      @category = Category.new
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
      render json: @category.errors.full_messages
    end
  end

  #because I can create a category with selectize gem, I've created the method htmlcreate for create a category by the normal html form

  def htmlcreate
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t('admin.categories.create.created')
      redirect_to admin_categories_path
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

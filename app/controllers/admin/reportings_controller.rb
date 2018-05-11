class Admin::ReportingsController < Admin::AdminController
  before_action :set_reporting

  def dismiss
    @tool = @reporting.tool
    if @tool.quantity < @reporting.quantity
      @tool.quantity = 0
      @tool.save
    else
      @tool.quantity = @tool.quantity - @reporting.quantity
      @tool.save
    end
    if @tool.books.where('end_date >= ?', Time.now).exists?
      @job = Delayed::Job.enqueue Admin::Checking.new(@tool, @tool.books.where('end_date >= ?', Time.now).count)
    end
    @reporting.destroy
    flash[:danger] = t('.dismiss')
    redirect_to admin_dashboard_index_path
  end

  def fix
    @reporting.destroy
    flash[:success] = t('.fix')
    redirect_to admin_dashboard_index_path
  end

  def replace
    @tool = @reporting.tool
    @reporting.destroy
    flash[:success] = t('.replace')
    redirect_to edit_admin_tool_path(@tool)
  end

  private

  def set_reporting
    @reporting = Reporting.find(params[:id])
  end

end

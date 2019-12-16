class Admin::ReportingsController < Admin::AdminController
  before_action :set_reporting

  #when a tool is reported, the admin can:
  #to dispose the quantity of object reported
  #fix the quantity of object reported
  #replace the quantity of object reported (if the tool have an identifier, else this action is the same of fix)

  def dismiss
    @tool = @reporting.tool
    @lab = @tool.labs_tools.where("lab_id = ?", @reporting.lab_id).first
    quantity = @lab.quantity
    if  quantity < @reporting.quantity
      @lab.quantity = 0
    else
      quantity = quantity - @reporting.quantity
      @lab.quantity = quantity
    end
    if @lab.save
      flash[:success] = "Success"
    #  if @tool.bookings.where('end_date >= ?', Time.now).exists?
    #    @job = Delayed::Job.enqueue Admin::Checking.new(@tool, @tool.bookings.where('end_date >= ?', Time.now).count) #for more info about this job see jobs/admin/checking.rb
    #  end
      TechnicalMailer.reporting_dismissed(@reporting.technical, @reporting).deliver_now
      @reporting.destroy
      flash[:danger] = t('.dismiss')
    else
      flash[:danger] = "oops"
    end
    redirect_to admin_dashboard_index_path
  end

  def fix
    TechnicalMailer.reporting_fixed(@reporting.technical, @reporting).deliver_now
    @reporting.destroy

    flash[:success] = t('.fix')
    redirect_to admin_dashboard_index_path
  end

  def replace
    @tool = @reporting.tool
    TechnicalMailer.reporting_replaced(@reporting.technical, @reporting).deliver_now
    @reporting.destroy
    flash[:success] = t('.replace')
    redirect_to edit_admin_tool_path(@tool)
  end

  private

  def set_reporting
    @reporting = Reporting.find(params[:id])
  end

end

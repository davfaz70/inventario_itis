class Technical::LabsController < Technical::TechnicalController

  def index
    @tool = Tool.friendly.find(params[:tool_id])
    @labs = @tool.labs
  end

  def show
    @lab = Lab.friendly.find(params[:id])
    if current_technical.labs.include?(@lab)
      if current_technical.lab_technicals.where("lab_id=?", @lab.id).first.end_date == nil
        @bookings = @lab.bookings.where("end_date > ? AND confirmed = ?", Time.now, true)
      elsif current_technical.lab_technicals.where("lab_id=?", @lab.id).first.end_date < Time.now
        redirect_back(fallback_location:  technical_dashboard_index_path)
      else
        @bookings = @lab.bookings.where("end_date > ? AND confirmed = ?", Time.now, true)
      end
    else
      redirect_back(fallback_location:  technical_dashboard_index_path)
    end
  end

end

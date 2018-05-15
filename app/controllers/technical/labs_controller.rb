class Technical::LabsController < Technical::TechnicalController

  def index
    @labs = current_technical.labs.distinct
    @tool = Tool.friendly.find(params[:tool_id])
  end

  def show
    @lab = Lab.friendly.find(params[:id])
    @bookings = @lab.books.where("end_date > ? AND confirmed = ?", Time.now, true)
  end

end

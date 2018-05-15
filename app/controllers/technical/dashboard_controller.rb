class Technical::DashboardController < Technical::TechnicalController

  def index
    @relations = current_technical.lab_technicals
  end

end

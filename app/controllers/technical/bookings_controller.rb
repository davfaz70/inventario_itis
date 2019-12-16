class Technical::BookingsController < Technical::TechnicalController

  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      redirect_back(fallback_location:  technical_dashboard_index_path)
    else
      redirect_back(fallback_location:  technical_dashboard_index_path)
    end
  end

end

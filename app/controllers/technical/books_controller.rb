class Technical::BooksController < Technical::TechnicalController

  def destroy
    @booking = Book.find(params[:id])
    if @booking.destroy
      redirect_back(fallback_location:  technical_dashboard_index_path)
    else
      redirect_back(fallback_location:  technical_dashboard_index_path)
    end
  end

end

class Admin::BooksController < Admin::AdminController
  before_action :set_book, only: [:update, :destroy]

  def index
    @tool = Tool.friendly.find(params[:tool_id])
    @bookings = @tool.books
  end

  def update
    @books = @booking.tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true)
      cont = 0

     @books.each do |b|
       if (@booking.start_date..@booking.end_date).overlaps?(b.start_date..b.end_date)
         cont = cont + b.quantity
       end
    end
    cont = cont + @booking.quantity
    if cont > @booking.tool.quantity
      flash[:danger]="Questo prodotto non è più disponibile per questo periodo, la prenotazione è stata eliminata ed è stato comunicato tutto al prenotatore"
      ProfMailer.destroy_booking(@booking.prof, @booking).deliver_now
      @booking.destroy
      redirect_back(fallback_location:  admin_dashboard_index_path)
    else
      if @booking.update(book_params)
        flash[:success]="La prenotazione è stata confermata"
        LabMailer.new_booking(@booking).deliver_now
        ProfMailer.confirmed_booking(@booking.prof, @booking).deliver_later
        if (@booking.start_date - Time.now)/1.day >= 1
          TomorrowBookingJob.set(wait_until: @booking.start_date.to_datetime - 1.day).perform_later(@booking)
        end
        if (@booking.end_date - @booking.start_date)/1.day >= 2
          TomorrowEndJob.set(wait_until: @booking.end_date.to_datetime - 1.day).perform_later(@booking)
        end
        redirect_back(fallback_location: root_path)
      else
        flash[:danger]="Qualcosa è andato storto, riprova"
        redirect_back(fallback_location:  admin_dashboard_index_path)
      end
    end
  end

  def destroy
    if @booking.destroy
      flash[:success]="La prenotazione è stata eliminata"
      ProfMailer.destroy_booking(@booking.prof, @booking).deliver_now
      redirect_back(fallback_location:  admin_dashboard_index_path)
    else
      flash[:danger]="Qualcosa è andato storto, riprova"
      redirect_back(fallback_location:  admin_dashboard_index_path)
    end
  end

  private

  def set_book
    @booking = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:prof_id, :tool_id, :start_date, :end_date, :quantity, :confirmed, :lab_id, :goal)
  end
end

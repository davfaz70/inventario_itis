class Admin::BooksController < Admin::AdminController
  before_action :set_book, only: [:update, :destroy]

  def index
    @tool = Tool.friendly.find(params[:tool_id])
    @bookings = @tool.books
  end

  def update
    #at this method we pass a booking and we must know the tool of that booking for obtain all the reservations that belongs to the tool
    @books = @booking.tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true)
      cont = 0
    # the system must check if that booking are not in conflict with other confirmated reservations
     @books.each do |b|
       if (@booking.start_date..@booking.end_date).overlaps?(b.start_date..b.end_date)
         cont = cont + b.quantity
       end
    end
    cont = cont + @booking.quantity
    if cont > @booking.tool.labs_tools.where("lab_id = ?", @book.lab_id).first.quantity
      flash[:danger]="Questo prodotto non è più disponibile per questo periodo, la prenotazione è stata eliminata ed è stato comunicato tutto al prenotatore"
      ProfMailer.destroy_booking(@booking.prof, @booking).deliver_now # this email notify at the prof that his booking was deleted because an other booking at the same range of time was confirmed before
      @booking.destroy
      redirect_back(fallback_location:  admin_dashboard_index_path)
    else
      if @booking.update(book_params)
        flash[:success]="La prenotazione è stata confermata"
        LabMailer.new_booking(@booking).deliver_now #this email notify at the prof that his booking was confirmed
        ProfMailer.confirmed_booking(@booking.prof, @booking).deliver_later
        if (@booking.start_date - Time.now)/1.day >= 1
          TomorrowBookingJob.set(wait_until: @booking.start_date.to_datetime - 1.day).perform_later(@booking)
          #if the booking was made one or more days in advance, this email will remind the prof his reservation
        end
        if (@booking.end_date - @booking.start_date)/1.day >= 2
          TomorrowEndJob.set(wait_until: @booking.end_date.to_datetime - 1.day).perform_later(@booking)
          #if the time interval between the start date and the end date is two or more days, this email will remind the prof the expiration of his reservation one day in advance
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

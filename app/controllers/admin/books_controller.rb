class Admin::BooksController < Admin::AdminController
  before_action :set_book

  def update
    @books = @booking.tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true)
      cont = 0

     @books.each do |b|
      if @booking.start_date >= b.start_date && @booking.start_date <= b.end_date
        cont = cont + b.quantity
      elsif @booking.end_date >= b.start_date && @booking.end_date <= b.end_date
        cont = cont + b.quantity
      elsif b.start_date >= @booking.start_date && b.start_date <= @booking.end_date
        cont = cont + b.quantity
      end
    end
    cont = cont + @booking.quantity
    if cont > @booking.tool.quantity
      flash[:danger]="Questo prodotto non è più disponibile per questo periodo, la prenotazione è stata eliminata ed è stato comunicato tutto al prenotatore"
      ProfMailer.destroy_booking(@booking.prof, @booking).deliver_now
      @booking.destroy
      redirect_back(fallback_location: root_path)
    else
      if @booking.update(book_params)
        flash[:success]="La prenotazione è stata confermata"
        ProfMailer.confirmed_booking(@booking.prof, @booking).deliver_later
        redirect_back(fallback_location: root_path)
      else
        flash[:danger]="Qualcosa è andato storto, riprova"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    if @booking.destroy
      flash[:success]="La prenotazione è stata eliminata"
      ProfMailer.destroy_booking(@booking.prof, @booking).deliver_now
      redirect_back(fallback_location: root_path)
    else
      flash[:danger]="Qualcosa è andato storto, riprova"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_book
    @booking = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:prof_id, :tool_id, :start_date, :end_date, :quantity, :confirmed)
  end
end

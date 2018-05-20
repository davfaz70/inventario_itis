class LabMailer < ApplicationMailer

  def new_booking(booking)
    @booking = booking
    if @booking.lab.lab_technicals.where(end_date = nil).present?
      @technical = @booking.lab.lab_technicals.where(end_date = nil).first.technical
      if @technical.present? 
        mail(to: @technical.email, subject: "Uno strumento del tuo laboratorio è stato prenotato")
      end
    end
  end

end

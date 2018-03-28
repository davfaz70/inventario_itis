class LabMailer < ApplicationMailer

  def new_booking(booking)
    @booking = booking
    @technical = @booking.lab.lab_technicals.where(end_date = nil).first.technical
    mail(to: @technical.email, subject: "Uno strumento del tuo laboratorio è stato prenotato")
  end

end

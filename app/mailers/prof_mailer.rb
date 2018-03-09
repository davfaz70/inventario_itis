class ProfMailer < ApplicationMailer

  def destroy_booking(prof, booking)
    @booking = booking
    @prof = prof
    @url = 'http://192.168.10.120:3000'
    mail(to: @prof.email, subject: "Una tua prenotazione è stata eliminata!")
  end

  def authorized(prof)
    @prof = prof
    mail(to: @prof.email, subject:"Sei stato autorizzato!")
  end

  def unauthorized(prof)
    @prof = prof
    mail(to: @prof.email, subject:"Non sei più autorizzato!")
  end

  def confirmed_booking(prof, booking)
    @booking = booking
    @prof = prof
    mail(to: @prof.email, subject: "Una tua prenotazione è stata confermata!")
  end
  
end

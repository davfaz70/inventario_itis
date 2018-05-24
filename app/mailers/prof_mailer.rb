class ProfMailer < ApplicationMailer

  def destroy_booking(prof, booking)
    @booking = booking
    @prof = prof
    @url = 'http://192.168.10.120:3000'
    mail(to: @prof.email, subject: "Una tua prenotazione è stata eliminata!")
  end

  def no_time_booking(prof, booking)
    @booking = booking
    @prof = prof
    mail(to: @prof.email, subject: "Una tua prenotazione non è stata confermata in tempo")
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

  def tomorrow_booking(prof, booking)
    @booking = booking
    @prof = prof
    mail(to: @prof.email, subject: "Hai una prenotazione per domani")
  end

  def tomorrow_end(prof, booking)
    @booking = booking
    @prof = prof
    mail(to: @prof.email, subject: "Domani scade il tuo periodo di prenotazione")
  end

  def request_approved(prof, request)
    @request = request
    @prof = prof
    mail(to: @prof.email, subject: "Una tua richiesta d'acquisto è stata approvata")
  end

  def request_money(prof, request)
    @request = request
    @prof = prof
    mail(to: @prof.email, subject: "Il bene da te richiesto è stato acquistato")
  end

  def tool_arrived(prof, tool)
    @tool = tool
    @prof = prof
    mail(to: @prof.email, subject: "Il bene da te richiesto è finalmente disponibile")
  end

  def request_not_approved(prof, request)
    @request = request
    @prof = prof
    mail(to: @prof.email, subject: "Una tua richiesta d'acquisto non è stata approvata")
  end

  def request_not_money(prof, request)
    @request = request
    @prof = prof
    mail(to: @prof.email, subject: "Il bene da te richiesto non è stato acquistato")
  end

  def destroyed(prof)
    @prof = prof
    mail(to: @prof.email, subject: "Sei stato cancellato")
  end


end

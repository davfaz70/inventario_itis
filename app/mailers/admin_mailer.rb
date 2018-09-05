class AdminMailer < ApplicationMailer

  def new_confirmated_prof(prof)
    @prof = prof
    mail(to: Admin.where("role = 1").first.email, subject: "Presto! Devi autorizzare un nuovo professore")
  end

  def new_booking
    @prof = params[:prof]
    @booking = params[:book]
    mail(to: Admin.where("role = 1").first.email, subject: "Nuova prenotazione")
  end

  def new_confirmated_technical(technical)
    @technical = technical
    mail(to: Admin.where("role = 1").first.email, subject: "Nuovo tecnico! Corri ad autorizzarlo")
  end

  def new_reporting(reporting)
    @reporting = reporting
    mail(to: Admin.where("role = 1").first.email, subject: "Nuova segnalazione di malfunzionamenti")
  end

  def new_request(request)
    @request = request
    if @request.prof.present?
      @person = @request.prof
    else
      @preson = @request.technical
    end
    mail(to: Admin.where("role = 0").first.email, subject: "Nuova proposta d'acquisto")
  end

  def request_approved(request)
    @request = request
    mail(to: Admin.where("role = 1").first.email, subject: "Una proposta d'acquisto è stata approvata")
  end

  def request_money(request)
    @request = request
    mail(to: Admin.where("role = 2").first.email, subject: "È stato acquistato un nuovo strumento")
  end


end

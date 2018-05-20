class TechnicalMailer < ApplicationMailer

  def authorized(technical)
    @technical = technical
    mail(to: @technical.email, subject:"Sei stato autorizzato!")
  end

  def unauthorized(technical)
    @technical = technical
    mail(to: @technical.email, subject:"Non sei più autorizzato!")
  end

  def request_approved(technical, request)
    @request = request
    @technical = technical
    mail(to: @technical.email, subject: "Una tua richiesta d'acquisto è stata approvata")
  end

  def request_money(technical, request)
    @request = request
    @technical = technical
    mail(to: @technical.email, subject: "Il bene da te richiesto è stato acquistato")
  end

  def tool_arrived(technical, tool)
    @tool = tool
    @technical = technical
    mail(to: @technical.email, subject: "Il bene da te richiesto è finalmente disponibile")
  end

  def request_not_approved(technical, request)
    @request = request
    @technical = technical
    mail(to: @technical.email, subject: "Una tua richiesta d'acquisto non è stata approvata")
  end

  def request_not_money(technical, request)
    @request = request
    @technical = technical
    mail(to: @technical.email, subject: "Il bene da te richiesto non è stato acquistato")
  end

  def reporting_fixed(technical, reporting)
    @reporting = reporting
    @technical = technical
    mail(to: @technical.email, subject: "Il bene da te segnalato è stato riparato")
  end

  def reporting_replaced(technical, reporting)
    @reporting = reporting
    @technical = technical
    mail(to: @technical.email, subject: "Il bene da te segnalato è stato sostituito")
  end

  def reporting_dismissed(technical, reporting)
    @reporting = reporting
    @technical = technical
    mail(to: @technical.email, subject: "Il bene da te segnalato è stato dismesso")
  end

end

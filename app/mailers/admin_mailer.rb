class AdminMailer < ApplicationMailer

  def new_confirmated_prof(prof)
    @prof = prof
    mail(to: Admin.first.email, subject: "Presto! Devi autorizzare un nuovo professore")
  end

end

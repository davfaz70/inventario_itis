class TomorrowEndJob < ApplicationJob
  queue_as :default

  def perform(booking)
    @booking = booking
    if @booking.present?
      ProfMailer.tomorrow_end(@booking.prof, @booking).deliver_now
    end
  end

end

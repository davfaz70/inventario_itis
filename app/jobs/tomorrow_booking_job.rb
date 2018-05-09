class TomorrowBookingJob < ApplicationJob
  queue_as :default

  def perform(booking)
    @booking = booking
    if @booking.present?
      ProfMailer.tomorrow_booking(@booking.prof, @booking).deliver_now
    end
  end
  
end

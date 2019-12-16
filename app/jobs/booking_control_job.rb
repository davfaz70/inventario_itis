class BookingControlJob < ApplicationJob
  queue_as :default

  def perform(booking)
    @booking = booking
    if @booking.present?
    if @booking.confirmed == false
      ProfMailer.no_time_booking(@booking.prof, @booking).deliver_now
      @booking.destroy
    end
  end
  end
end

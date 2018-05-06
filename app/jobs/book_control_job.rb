class BookControlJob < ApplicationJob
  queue_as :default

  def perform(book)
    @booking = book
    if @booking.present?
    if @booking.confirmed == false
      ProfMailer.no_time_booking(@booking.prof, @booking).deliver_now
      @booking.destroy
    end
  end
  end
end

class BookControlJob < ApplicationJob
  queue_as :default

  def perform(book)
    @booking = book
    if @booking.confirmed == false
      @booking.destroy
    end
  end
end

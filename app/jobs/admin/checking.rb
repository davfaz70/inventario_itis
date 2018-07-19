class Admin::Checking < ProgressJob::Base

#when the admin reduce the quantity of a tool, if there are a confirmed booking for previous quantity, that now is too much, this booking must be deleted

  def initialize(tool, progress_max)
    super progress_max: progress_max
    @tool = tool
  end

  def perform
    @book1 = @tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true).order(created_at: :desc)
    @book1.each do |booking|
      cont = 0
      @tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true).order(created_at: :desc).each do |b|
        #this query is refreshed at every loop for avoid frozen variable
          if (booking.start_date..booking.end_date).overlaps?(b.start_date..b.end_date)
            cont = cont + b.quantity
          end
        end
        update_progress
      if cont > @tool.quantity
        ProfMailer.destroy_booking(booking.prof, booking).deliver_now
        booking.destroy
      end

      end
    end
end

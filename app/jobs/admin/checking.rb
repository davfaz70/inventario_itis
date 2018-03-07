class Admin::Checking < ProgressJob::Base
  def initialize(tool, progress_max)
    super progress_max: progress_max
    @tool = tool
  end

  def perform
    @book1 = @tool.books.where('end_date >= ?', Time.now).order(created_at: :desc)
    @book1.each do |booking|
      cont = 0
      @tool.books.where('end_date >= ?', Time.now).order(created_at: :desc).each do |b|
          if booking.start_date >= b.start_date && booking.start_date <= b.end_date
            cont = cont + b.quantity
          elsif booking.end_date >= b.start_date && booking.end_date <= b.end_date
            cont = cont + b.quantity
          elsif b.start_date >= booking.start_date && b.start_date <= booking.end_date
            cont = cont + b.quantity
          end
        end
        update_progress
      if cont >= @tool.quantity
        #send_email_to_booking.prof_email
        booking.destroy
      end

      end
    end
end

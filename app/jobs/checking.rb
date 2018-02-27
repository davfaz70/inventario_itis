class ChekingJob < ProgressJob::Base
  def initialize(tool, progress_max)
    super progress_max: progress_max
    @book1 = tool.books.where('end_date >= ?', Time.now).order(created_at: :desc)
    @tool = tool
  end
  def perform
    @book1.each do |booking|
      cont = 0
      @tool.books.where('end_date >= ?', Time.now).order(created_at: :desc).each do |b|
        if b.id != booking.id
          if booking.start_date >= b.start_date && booking.start_date <= b.end_date
            cont = cont + b.quantity
          elsif booking.end_date >= b.start_date && booking.end_date <= b.end_date
            cont = cont + b.quantity
          elsif b.start_date >= booking.start_date && b.start_date <= booking.end_date
            cont = cont + b.quantity
          end
        end
      end
      update_progress
      if cont >= @tool.quantity
        booking.destroy
      end
    end
  end
end

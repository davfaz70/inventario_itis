class TempbooksController < ApplicationController
  before_action :authenticate_prof!, only: [:new]
  before_action :authorized_prof, only: [:create]

  # A tempbook is a temporary booking, it is useful for check the availability of tools without make a real booking
  # A tempbook permit to the system to check if the booking that i want to create not make conflict to other confirmated bookings

  def new
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build
  end

  def avaiable #this method check the availability of a tool in a range of time
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build(tempbook_params)
    if @tempbook.save
      cont = 0 #this variable count how many times the range of time that i have choice overlaps with other bookings
      @tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true).each_with_index do |b, i|
        if (@tempbook.start_date..@tempbook.end_date).overlaps?(b.start_date..b.end_date)
          cont = cont + b.quantity #since in a reservation I can choose how many tools to use, the variable cont must contain the number of tools booked
        end
      end
      #at the end, the variable cont contain the number of tools that are already booked for this range of time
      max =  @tool.quantity - cont
        if max == 1
          flash[:info]="#{t('.periods')} #{max} #{t('.tool')}"
        else
          flash[:info]="#{t('.periodp')} #{max} #{t('.tools')}"
        end
      @tempbook.destroy
      redirect_to tool_path(@tool)
    else
      render :new
    end
  end

  # When a prof make a booking, the system must check that the booking are not in conflict with other confirmated reservations
  def create
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build(tempbook_params)
    if @tempbook.save
      cont = 0 #this variable and the following loop have the same purpose that in 'avaiable' method
      @tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true).each_with_index do |b, i| # for simplify the procedure, the system check only reservations that are already confirmed
        if (@tempbook.start_date..@tempbook.end_date).overlaps?(b.start_date..b.end_date)
          cont = cont + b.quantity
        end
      end
      cont = cont + @tempbook.quantity
      if cont > @tool.quantity
        max = @tool.quantity - cont + @tempbook.quantity
        if max == 1
          flash[:danger]="#{t('.looking')} #{max} #{t('tempbooks.avaiable.tool')}"
        else
          flash[:danger]="#{t('.lookings')} #{max} #{t('tempbooks.avaiable.tools')}"
        end
        @tempbook.destroy
        redirect_to tool_path(@tool)
      else #if the booking are not in conflict with other confirmated resarvations, the system create a new book entity
        @book = @tool.books.build
        @book.prof_id = @tempbook.prof_id
        @book.start_date = @tempbook.start_date
        @book.end_date = @tempbook.end_date
        @book.quantity = @tempbook.quantity
        @book.lab_id = @tempbook.lab_id
        @book.goal = @tempbook.goal
        @tempbook.destroy
        if @book.save
          flash[:success]="Prenotato con successo"
          #BookControlJob.set(wait_until: @book.start_date.to_datetime).perform_later(@book) #if the booking are not confirmed before the start date, is unuseful store it in the database
          AdminMailer.with(book: @book, prof: @book.prof).new_booking.deliver_later #this email notify at the admin that a new booking was created
          redirect_to tool_path(@tool)
        else
          flash[:danger]="C'è stato un problema, riprova"
          redirect_to tool_path(@tool)
        end
      end
      else
        flash[:danger] = @tempbook.errors.full_messages
        redirect_to tool_path(@tool)
    end
  end

  private

  def control(tool)
    @tool = tool
    if @tool.quantity == 0
      flash[:danger] = t('.impossible')
      redirect_to tools_path
    end
  end

  def tempbook_params
    params.require(:tempbook).permit(:prof_id, :tool_id, :start_date, :end_date, :quantity, :lab_id, :goal)
  end
end

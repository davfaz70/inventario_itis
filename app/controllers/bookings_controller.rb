class BookingsController < ApplicationController
  before_action :authenticate_prof!
  def index
    @bookings = current_prof.bookings
  end

  def new
    @tool = Tool.friendly.find(params[:tool_id])
    if @tool.labs.size == 0
      flash[:danger]="#{t('bookings.avaiable.periodp')} 0 #{t('bookings.avaiable.tools')}"
      redirect_to tool_path(@tool)
    end
    @booking = @tool.bookings.build
  end

  def avaiable #this method check the availability of a tool in a range of time
    @tool = Tool.friendly.find(params[:tool_id])

    @booking = @tool.bookings.build(booking_params)
    if @booking.save
      cont = 0 #this variable count how many times the range of time that i have choice overlaps with other bookings
      @tool.bookings.where('end_date >= ? AND confirmed = ? AND lab_id = ?', Time.now, true, @booking.lab_id).each do |b|
        if (@booking.start_date..@booking.end_date).overlaps?(b.start_date..b.end_date)
          cont = cont + b.quantity #since in a reservation I can choose how many tools to use, the variable cont must contain the number of tools booked
        end
      end
      #at the end, the variable cont contain the number of tools that are already booked for this range of time
      max =  @tool.labs_tools.where("lab_id = ?", @booking.lab_id).first.quantity - cont
        if max == 1
          flash[:info]="#{t('.periods')} #{max} #{t('.tool')}"
        else
          flash[:info]="#{t('.periodp')} #{max} #{t('.tools')}"
        end
      @booking.destroy
      redirect_to tool_path(@tool)
    else
      render :new
    end
  end

  # When a prof make a booking, the system must check that the booking are not in conflict with other confirmated reservations
  def create
    @tool = Tool.friendly.find(params[:tool_id])
    @booking = @tool.bookings.build(booking_params)
    if @booking.save
      cont = 0 #this variable and the following loop have the same purpose that in 'avaiable' method
      @tool.bookings.where('end_date >= ? AND confirmed = ? AND lab_id = ?', Time.now, true, @booking.lab_id).each do |b| # for simplify the procedure, the system check only reservations that are already confirmed
        if (@booking.start_date..@booking.end_date).overlaps?(b.start_date..b.end_date)
          cont = cont + b.quantity
        end
      end
      cont = cont + @booking.quantity
      quantity_tool = @tool.labs_tools.where("lab_id = ?", @booking.lab_id).first.quantity
      if cont > quantity_tool
        max = quantity_tool - cont + @booking.quantity
        if max == 1
          flash[:danger]="#{t('.looking')} #{max} #{t('bookings.avaiable.tool')}"
        else
          flash[:danger]="#{t('.lookings')} #{max} #{t('bookings.avaiable.tools')}"
        end
        @booking.destroy
        redirect_to tool_path(@tool)
      else #if the booking are not in conflict with other confirmated resarvations, the system create a new booking entity
        flash[:success]="Prenotato con successo"
        #BookingControlJob.set(wait_until: @booking.start_date.to_datetime).perform_later(@booking) #if the booking are not confirmed before the start date, is unuseful store it in the database
        AdminMailer.with(booking: @booking, prof: @booking.prof).new_booking.deliver_later #this email notify at the admin that a new booking was created
        redirect_to tool_path(@tool)
      end
    else
      flash[:danger] = @booking.errors.full_messages
      redirect_to tool_path(@tool)
    end
  end

  private

  def control(tool)
    @tool = tool
    if @tool.labs_tools.size == 0
      flash[:danger] = t('.impossible')
      redirect_to tools_path
    end
  end

  def booking_params
    params.require(:booking).permit(:prof_id, :tool_id, :start_date, :end_date, :quantity, :lab_id, :goal)
  end
end

  #This is a controller only for show the reservations of logged prof, chech the app/views/bookings/index.html.erb for more information

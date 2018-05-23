class TempbooksController < ApplicationController
  before_action :authenticate_prof!, only: [:new]
  before_action :authorized_prof, only: [:create]

  def new
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build
  end

  def avaiable
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build(tempbook_params)
    if @tempbook.save
      cont = 0
      @tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true).each_with_index do |b, i|
        if (@tempbook.start_date..@tempbook.end_date).overlaps?(b.start_date..b.end_date)
          cont = cont + b.quantity
        end
      end
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


  def create
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build(tempbook_params)
    if @tempbook.save
      cont = 0
      @tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true).each_with_index do |b, i|
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
      else
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
          BookControlJob.set(wait_until: @book.start_date.to_datetime).perform_later(@book)
          AdminMailer.new_booking(@book.prof, @book).deliver_later
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

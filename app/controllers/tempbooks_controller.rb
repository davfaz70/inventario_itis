class TempbooksController < ApplicationController
  before_action :authenticate_prof!, only: [:new]
  before_action :authorized_prof, only: [:new]
  def new
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build
    @booking = @tool.books.where('end_date >= ?', Time.now)
  end

  def create
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build(tempbook_params)
    if @tempbook.save
      cont = 0
      @tool.books.where('end_date >= ?', Time.now).each_with_index do |b, i|
        if @tempbook.start_date >= b.start_date && @tempbook.start_date <= b.end_date
          cont = cont + b.quantity
        elsif @tempbook.end_date >= b.start_date && @tempbook.end_date <= b.end_date
          cont = cont + b.quantity
        elsif b.start_date >= @tempbook.start_date && b.start_date <= @tempbook.end_date
          cont = cont + b.quantity
        end
      end
      cont = cont + @tempbook.quantity
      if cont > @tool.quantity
        flash[:danger]="Guarda meglio le prenotazioni, noterai che tale quantità in questo periodo di tempo non è disponibile"
        @tempbook.destroy
        render 'new'
      else
        @book = @tool.books.build
        @book.prof_id = @tempbook.prof_id
        @book.start_date = @tempbook.start_date
        @book.end_date = @tempbook.end_date
        @book.quantity = @tempbook.quantity
        @tempbook.destroy
        if @book.save
          flash[:success]="Prenotato con successo"
          redirect_to tools_path
        else
          flash[:danger]="C'è stato un problema, riprova"
          render 'new'
        end
      end
      else
        render 'new'
    end
  end

  private

  def tempbook_params
    params.require(:tempbook).permit(:prof_id, :tool_id, :start_date, :end_date, :quantity)
  end
end

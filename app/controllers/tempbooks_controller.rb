class TempbooksController < ApplicationController
  before_action :authenticate_prof!, only: [:new]
  before_action :authorized_prof, only: [:new]

  def create
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build(tempbook_params)
    if @tempbook.save
      cont = 0
      @tool.books.where('end_date >= ? AND confirmed = ?', Time.now, true).each_with_index do |b, i|
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
        redirect_to tool_path(@tool)
      else
        @book = @tool.books.build
        @book.prof_id = @tempbook.prof_id
        @book.start_date = @tempbook.start_date
        @book.end_date = @tempbook.end_date
        @book.quantity = @tempbook.quantity
        @tempbook.destroy
        if @book.save
          flash[:success]="Prenotato con successo"
          redirect_to tool_path(@tool)
        else
          flash[:danger]="C'è stato un problema, riprova"
          redirect_to tool_path(@tool)
        end
      end
      else
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
    params.require(:tempbook).permit(:prof_id, :tool_id, :start_date, :end_date, :quantity)
  end
end

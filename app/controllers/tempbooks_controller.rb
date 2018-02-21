class TempbooksController < ApplicationController
  before_action :authenticate_prof!, only: [:new]
  def new
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build
  end

  def create
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build(tempbook_params)
    if @tempbook.save
      cont = 0
      @tool.books.each_with_index do |b, i|
        if b.fd >= Time.now
        if @tempbook.sd >= b.sd && @tempbook.sd <= b.fd
          cont = cont + b.quantity
        elsif @tempbook.fd >= b.sd && @tempbook.fd <= b.fd
          cont = cont + b.quantity
        elsif b.sd >= @tempbook.sd && b.sd <= @tempbook.fd
          cont = cont + b.quantity
        end
      end
      end
      cont = cont + @tempbook.quantity
      if cont > @tool.quantity
        flash[:danger]="Guarda meglio le prenotazioni, noterai che tale quantità in questo periodo di tempo non è disponibile"
        @tempbook.destroy
        render 'new'
      else
        @book = @tool.books.build
        @book.prof = @tempbook.prof
        @book.sd = @tempbook.sd
        @book.fd = @tempbook.fd
        @book.prof_surname = @tempbook.prof_surname
        @book.prof_email = @tempbook.prof_email
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
    params.require(:tempbook).permit(:prof, :tool_id, :sd, :fd, :prof_email, :prof_surname, :quantity)
  end
end

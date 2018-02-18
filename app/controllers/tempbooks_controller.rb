class TempbooksController < ApplicationController
  def new
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build
  end

  def create
    @tool = Tool.friendly.find(params[:tool_id])
    @tempbook = @tool.tempbooks.build(tempbook_params)
    if @tempbook.save
      cont = 0
      @date = Array.new(@tool.quantity)
      @tool.books.each_with_index do |b, i|
        if @tempbook.sd >= b.sd && @tempbook.sd <= b.fd
          cont = cont + 1
          @date[i] = b
        elsif @tempbook.fd >= b.sd && @tempbook.fd <= b.fd
          cont = cont + 1
          @date[i] = b
        elsif b.sd >= @tempbook.sd && b.sd <= @tempbook.fd
          cont = cont + 1
          @date[i] = b
        end
      end
      if cont >= @tool.quantity
        @date.each do |d|
          if d != nil
            flash[:danger]="Già prenotato dal " + d.sd.to_s + " al " + d.fd.to_s
          end
        end
        @tempbook.destroy
        render 'new'
      else
        @book = @tool.books.build
        @book.prof = @tempbook.prof
        @book.sd = @tempbook.sd
        @book.fd = @tempbook.fd
        @book.prof_surname = @tempbook.prof_surname
        @book.prof_email = @tempbook.prof_email
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
    params.require(:tempbook).permit(:prof, :tool_id, :sd, :fd, :prof_email, :prof_surname)
  end
end

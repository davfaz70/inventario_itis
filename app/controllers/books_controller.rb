class BooksController < ApplicationController
  before_action :authenticate_prof!
  def index
    @bookings = current_prof.books
  end
  #This is a controller only for show the reservations of logged prof, chech the app/views/books/index.html.erb for more information
end

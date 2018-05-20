class BooksController < ApplicationController
  before_action :authenticate_prof!
  def index
    @bookings = current_prof.books
  end
end

module Admin::AdminHelper

  def menu
    @profcount = Prof.where("authorized = 'f' AND confirmed_at IS NOT NULL").count
    @bookcount = Booking.where("confirmed = ?", false).count
    @count = @profcount + @bookcount
    @profs = Prof.where("authorized = ? AND confirmed_at IS NOT NULL", false).limit(2)
    @bookings = Booking.where("confirmed = ?", false).limit(2)

    @requestcountna = Request.where("approved = 'f'").count
    @requestsna = Request.where("approved = 'f'").limit(4)

    @requestrepo = Request.where("approved = 't' AND money = 'f'").count + Reporting.count
    @requestsa = Request.where("approved = 't' AND money = 'f'").limit(4)
    @reportings = Reporting.all.limit(4)

    @requestcountm = Request.where("approved = 't' AND money = 't'").count
    @requestsm = Request.where("approved = 't' AND money = 't'").limit(4)
  end

end

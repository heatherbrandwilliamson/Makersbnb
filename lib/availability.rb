class Availability
  def list(bookings)
    date_range = (Date.today..Date.today + 14).map { |date| date.to_s }

    booking_dates = []

    bookings.each do |booking|
      if booking.approved == "t"
        booking_dates << booking.date
      end
    end

    available_dates = date_range - booking_dates

    return available_dates
  end
end

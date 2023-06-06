require_relative 'booking'

class BookingRepository
  def create(booking)
    sql = 'INSERT INTO bookings (user_id, property_id, date) VALUES($1, $2, $3);'
    DatabaseConnection.exec_params(sql, [booking.user_id, booking.property_id, booking.date])
  end
end
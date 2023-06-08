require_relative 'booking'

class BookingRepository
  def create(booking)
    sql = 'INSERT INTO bookings (user_id, property_id, date, approved) VALUES($1, $2, $3, FALSE);'
    DatabaseConnection.exec_params(sql, [booking.user_id, booking.property_id, booking.date])
  end
  
  def find_by_property_id(id)
    sql = 'SELECT id, user_id, property_id, date, approved FROM bookings WHERE property_id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])
    
    bookings = []
    
    result_set.each do |result|
      booking = Booking.new
      booking.id = result['id'].to_i
      booking.user_id = result['user_id'].to_i
      booking.property_id = result['property_id'].to_i
      booking.date = result['date']
      booking.approved = result['approved']
      
      bookings << booking
    end    
    return bookings
  end
end

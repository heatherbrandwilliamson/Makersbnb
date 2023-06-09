require_relative 'booking'

class BookingRepository
  def create(booking)
    
    sql = 'INSERT INTO bookings (user_id, property_id, date, approved, host_id) VALUES($1, $2, $3, $4, $5);'
    DatabaseConnection.exec_params(sql, [booking.user_id, booking.property_id, booking.date, "FALSE", booking.host_id])
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

  def find_unapproved(host_id)
 
    sql = 'SELECT bookings.id AS booking_id,
    bookings.user_id AS guest_id,
    bookings.property_id AS property_id,
    bookings.date AS booking_date,
    bookings.approved AS booking_approved,
    bookings.host_id AS host_id,
    properties.id AS property_id,
    properties.property_name AS property_name
    FROM bookings
    JOIN properties ON properties.id = bookings.property_id
    WHERE approved = FALSE AND host_id = $1;'
    
    result_set = DatabaseConnection.exec_params(sql, [host_id])
    
    bookings = []
    
    result_set.each do |result|
      booking = Booking.new
      booking.id = result['booking_id'].to_i
      booking.user_id = result['guest_id'].to_i
      booking.property_id = result['property_id'].to_i
      booking.date = result['booking_date']
      booking.approved = result['booking_approved']
      booking.property_name = result['property_name']
      
      bookings << booking
    end
    return bookings
  end

  def confirm_booking(id)
    sql = 'UPDATE bookings SET approved = TRUE WHERE id = $1;'
    DatabaseConnection.exec_params(sql, [id])
  end
end

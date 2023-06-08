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
    # Get the ID of the logged-in host => 1
    # SELECT properties belonging to host
    # 
    sql = 'SELECT id, user_id, property_id, date, approved, host_id FROM bookings WHERE approved = FALSE AND host_id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [host_id])
    
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

  def confirm_booking(id)
    sql = 'UPDATE bookings SET approved = TRUE WHERE id = $1;'
    DatabaseConnection.exec_params(sql, [id])
  end
end

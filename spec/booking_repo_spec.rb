require 'booking_repository'

def reset_db
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe BookingRepository do
    before(:each) do 
      reset_db
    end

    describe "#create" do
    it "creates a new Booking" do
      booking = Booking.new
      booking.user_id = 1
      booking.property_id = 1
      booking.date = '29 May 2023'
      
      repo = BookingRepository.new
      repo.create(booking)
    end
  end
end
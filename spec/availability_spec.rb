require 'booking_repository'
require 'availability'

def reset_db
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: ENV['DB_NAME'] })
  connection.exec(seed_sql)
end

describe Availability do
    before(:each) do 
      reset_db
    end

    describe "#list" do
      it "returns of a list of available dates for a property" do
        bookings = BookingRepository.new.find_by_property_id(1)
        availability = Availability.new
        
        available_dates = availability.list(bookings) # => returns an array of available dates
        expect(available_dates.length).to eq 14
      end
    end
end

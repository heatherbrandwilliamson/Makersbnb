require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/property_repository'
require_relative 'lib/database_connection'
require_relative 'lib/booking_repository'

DatabaseConnection.connect('makersbnb_test')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/properties/new' do
    return erb(:new_property)
  end

  get '/properties/:id' do
    repo = PropertyRepository.new
    @property = repo.find((params[:id]))

      return erb(:property_listing)
  end   

  post '/properties' do
    
    @property = Property.new
    @property.property_name = params[:property_name]
    @property.location = params[:location]
    @property.description = params[:description]
    @property.price = params[:price]
    @property.user_id = params[:user_id]

    repo = PropertyRepository.new
    repo.create(@property)
    
    return erb(:property_confirmation)
  end

  get '/properties' do
    repo = PropertyRepository.new
    @properties = repo.all
      return erb(:properties)
  end

  get '/bookings/new/:id' do
    @property_id = params[:id]
    return erb(:booking_form)
  end

  post '/bookings' do
    booking = Booking.new
    booking.user_id = 1
    booking.property_id = params[:property_id]
    booking.date = params[:date]

    repo = BookingRepository.new
    repo.create(booking)

    return erb(:booking_confirmation)
  end
    
end
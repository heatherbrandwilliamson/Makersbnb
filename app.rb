require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/property_repository'
require_relative 'lib/database_connection'
require_relative 'lib/booking_repository'
require_relative 'lib/user_repo'
require 'bcrypt'
require_relative 'lib/availability'

DatabaseConnection.connect

class Application < Sinatra::Base
  enable :sessions
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

    bookings = BookingRepository.new.find_by_property_id((params[:id]))
    availability = Availability.new
    @available_dates = availability.list(bookings)
    
    return erb(:property_listing)
  end   

  post '/properties' do
    
    @property = Property.new
    @property.property_name = params[:property_name]
    @property.location = params[:location]
    @property.description = params[:description]
    @property.price = params[:price]
    @property.user_id = params[:user_id]
    @property.image_url = params[:image_url]

    repo = PropertyRepository.new
    repo.create(@property)
    
    return erb(:property_confirmation)
  end

  get '/properties' do
    repo = BookingRepository.new
    @bookings = repo.find_unapproved(session[:user_id])
    
    repo = PropertyRepository.new
    @properties = repo.all
    return erb(:properties)
  end

  get '/bookings/new/:id' do
    @property_id = params[:id]
    return erb(:booking_form)
  end
    
  get '/bookings/approve' do
    repo = BookingRepository.new
    @bookings = repo.find_unapproved(session[:user_id])
   
    return erb(:booking_approval)
  end

  post '/bookings/approve' do
    repo =BookingRepository.new
    repo.confirm_booking(params[:booking_id])

    return 'Booking Confirmed'
  end

  post '/bookings' do
    booking = Booking.new
    booking.user_id = session[:user_id]
    booking.property_id = params[:property_id]
    booking.date = params[:date]
    booking.host_id = params[:host_id].to_i
    
    repo = BookingRepository.new
    repo.create(booking)

    return erb(:booking_confirmation)
  end
    
# end
  get '/user' do
    erb :register
  end

  post '/user' do
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.phone_number = params[:phone_number]
    user.password = params[:password]

    repo = UserRepository.new()
    result = repo.create(user)
    erb(:successful_registration) 
    #return "User created successfully!"
  end
  #redirect to new page once user is created successfully.

  get '/index.html' do
    return erb (:index)
  end

  get '/user/new' do
    return erb(:user)
  end

  #User login#
  get '/user/login' do
    return erb(:login)
    # return erb(:test)
  end

  #This goes to fail login page. Login button works and redirects to index
  # post '/user/fail_login' do
  #   return erb(:index)
  # end
  
  #
  post '/user/login' do
    user = UserRepository.new.find_by_email(params[:email])
    if user == nil || params[:email].empty? || params[:password].empty?
      @error_message = "That email address wasn't found."
      status 401
      return erb(:failed_login)
    end

    if BCrypt::Password.new(user.password).is_password? params[:password]
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect '/properties' #change this to properties#
    else
      @error_message = "That password wasn't correct."
      status 401
      return erb(:failed_login)
    end
  end

  ## THIS IS AN ISSUE THAT NEEDS RESOLVING ASAP. WHETHER A USER ## ##
  ## PASSES A LOGIN DETAIL CORRECTLY OR INCORRECTLY THE PAGE    ## ##
  ## REFRESHES                                                  ## ##
  get '/user/fail_login' do
    return erb(:fail_login)
  end

  post '/user/fail_login' do
      user = UserRepository.new.find_by_email(params[:email])
    
      if user.nil? || params[:email].empty? || params[:password].empty?
        @error_message = "That email address wasn't found."
        status 401
        return erb(:failed_login)
      end
    
      if BCrypt::Password.new(user.password).is_password?(params[:password])
        session[:user_id] = user.id
        session[:user_name] = user.name
        redirect '/properties' # Redirect to the properties page
      else
        @error_message = "That password wasn't correct."
        status 401
        return erb(:failed_login)
    end
  end
end

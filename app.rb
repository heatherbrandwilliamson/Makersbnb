require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_repo'
require_relative 'lib/database_connection'
require 'bcrypt'

DatabaseConnection.connect("makersbnb_test")

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

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
    #return erb(:successful_registration) 
    return "User created successfully!"
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
  end

  post '/user/login' do
    user = UserRepository.new.find_by_email(params[:email])
    if user == nil || params[:email].empty? || params[:password].empty?
      @error_message = "That email address wasn't found."
      status 401
      return erb(:error)
    end

    if BCrypt::Password.new(user.password).is_password? params[:password]
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect '/index.html' #change this to property#
    else
      @error_message = "That password wasn't correct."
      status 401
      return erb(:error)
    end
  end
end

    #return erb(:successful_registration) 
#    
#   end
# end


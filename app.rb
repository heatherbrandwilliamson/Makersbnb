require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_repo'
require_relative 'lib/database_connection'

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

  get '/index.html' do
    erb :index
  end
  #redirect to new page once user is created successfully.

  get '/user/new' do
    return erb(:user)
  end
end

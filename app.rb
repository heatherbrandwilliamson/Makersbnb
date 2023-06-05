require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/registration'


class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    name = params[:name]
    email = params[:email]
    password = params[:password]

    registration = Registration.new(name, email, password)
    result = registration.register

    # Do something with the result, such as displaying a success message or handling errors

    # Return a response
    # Example: "User registration successful!"
  end

  # Other routes and methods

end

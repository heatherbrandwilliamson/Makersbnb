require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/property_repository'
require_relative 'lib/database_connection'

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
end
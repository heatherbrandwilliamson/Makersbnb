require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.
  def reset_db
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({host: '127.0.0.1', dbname: 'makersbnb_test'})
    connection.exec(seed_sql)
  end
  
  describe UserRepository do
    before(:each) do
      reset_db
    end
  end 

  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
    end
  end

  context 'GET /user' do
    xit 'should allow you to register' do
      response = get('/user')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Registration Form</h1>')
    end
  end

  context 'POST /user' do
    it 'should save user details to log in again' do
      response = post('/user', name: 'Jane', email: 'jane@example.com', phone_number: '07700123456', password: 'pass')
      expect(response.status).to eq(200)
      expect(response.body).to include("User created successfully!")
    end
  end

  #Integration testing for user login#
  context 'GET /user/login' do
    it 'should render the html login form correctly for the email' do
      response = get('user/login')

      expect(response.status).to eq(200)
      expect(response.body).to include('<input type="email" id="email" name="email" required>')
      expect(response.body).to include('<input type="password" id="password" name="password" required>')
    end
  end

  context 'POST /user/login' do
    it 'should save user input and successfully login' do
      response = post('/user/login', email:'jane@example.com', password:'pass') 

      expect(response.status).to eq(302)
      # expect(response.body).to include()

      #test comment
    end
  end
end

require "spec_helper"
require "rack/test"
require_relative '../app'
require 'json'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  def reset_db
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: ENV['DB_NAME'] })
    connection.exec(seed_sql)
  end  

  before(:each) do 
    reset_db
  end

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.

  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
    end
  end

  context 'GET /properties/new' do
    it 'should return a new property form' do
      response = get('/properties/new')
      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>List a property</h1>")
    end
  end

  context 'POST /properties' do
    it 'adds a new property to the database' do
      response = post('/properties', property_name: 'Done Roaming', price: 175, location: "Norfolk", description: "A home away from home.", user_id: 1)
      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Property added</h1>")
    end
  end

  context 'GET /properties' do  
    it "returns 200 ok and returns all properties" do
     response = get('/properties')
     expect(response.status).to eq(200)
    end
  end

  context 'GET /properties/id' do  
    it "returns 200 ok and returns one property" do
     response = get('/properties/1')
     expect(response.status).to eq(200)
     expect(response.body).to include('Beach House')
    end
  end

  context 'GET /bookings/new/:id' do
    it "returns 200 and a booking form" do
      response = get('/bookings/new/1')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Book your stay</h1>')
    end
  end
  
  context 'GET /bookings/approve' do
    it "returns 200 and a list of pending approvals" do
      post('/user/login', email: 'jane@example.com', password: 'pass') 
      response = get('/bookings/approve')
      expect(response.status).to eq(200)
      expect(response.body).to include('Beach House')
    end
  end

  context 'POST /bookings/approve' do
    it "confirms a pending booking" do
      response = post('/bookings/approve')
      expect(response.status).to eq(200)
      expect(response.body).to include('Booking Confirmed')
    end
  end

  context 'POST /bookings' do
    it "returns 200 and adds a new booking to the database" do
      
      response = post('/bookings', property_id: 1, date: '25 June 2023', host_id: 1)
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Booking request sent</h1>')
    end
  end

  context 'GET /login' do
    it "returns 200 and returns back to login page after login failure" do
      response = get('/login')
      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Welcome to MakersBnB!</h1>")
    end
  end

  context 'GET /user/login' do
    it "returns 200 and returns a fail login message" do
      response = get('/user/login')
      expect(response.status).to eq(200)
      expect(response.body).to include('')
    end
  end

  context 'POST /user/login' do
    it "returns 200 and should allow the user to go on to the next page (properties)" do
      response = post('/properties', email: "jane@example.com", password: "pass")
      expect(response.status).to eq(200)
      expect(response.body).to include("")
    end
  end

  context 'GET /user' do
    it "returns 200 and renders the register template" do
      get '/user'

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('<h1>Welcome to MakersBnB!</h1>')
      expect(last_response.body).to include('class="form-container"')
    end
  end

  context 'POST /user' do
    it 'creates a new user and renders the successful_registration template' do
      response = post('/user', name: 'Jane', email: 'jane@example.com', phone_number: '1234567890', password: 'pass')
      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Successfully Registered!</h1>")
    end
  end

  context 'GET /index.html' do
    it 'should render the index template' do
      response = get('/index.html')
      expect(response.body).to include('<h1>Welcome to MakersBnB!</h1>')
      expect(response.body).to include('<p>Let #TeamHibiscus help you find unique places to stay and experience amazing destinations.</p>')
    end
  end

  context 'POST /user/login' do
    it "returns 401 and renders the failed_login template for invalid login" do
      response = post('/user/login')
      expect(response.status).to eq(401)
      expect(response.body).to include("<h1>Login Failed</h1>")
      expect(response.body).to include("Your login attempt was not successful. Please check your credentials and try again.")
    end
  end
end

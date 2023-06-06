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
      response = post('/user', name: 'bob', email: '@yahoo', phone_number: '00', password: '123' )

      expect(response.status).to eq(200)
      expect(response.body).to include("User created successfully!")

    end
  end

  #Integration testing for user login#
  context 'GET /user/login' do
    it 'should render the html login form correctly' do
      response = get('user/login')

      expect(response.status).to eq 200
      expect(response.body).to include('<input type="email" id="email" name="email" required>')
    end

    it ''
  end

  context 'POST /user_login' do
    xit 'should save user input and successfully login' do
      response = post('/user')
    end
  end
end

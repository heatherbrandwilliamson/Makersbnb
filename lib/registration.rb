# registration.rb
require 'pg'

class Registration
  attr_accessor :name, :email, :password

  def initialize(name, email, password)
    @name = name
    @email = email
    @password = password
  end

  def register
    begin
      connection = PG.connect(dbname: 'your_database_name', user: 'your_username', password: 'your_password')
      query = "INSERT INTO users (name, email, password) VALUES ($1, $2, $3)"
      values = [@name, email, password]
      connection.exec_params(query, values)

      "User registration successful!"
    rescue PG::Error => e
      "An error occurred during registration: #{e.message}"
    ensure
      connection&.close
    end
  end
end

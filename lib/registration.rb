require 'pg'

class Registration
  attr_accessor :name, :email, :phone_num, :password

  def initialize(name, email, phone_num, password)
    @name = name
    @email = email
    @phone_num = phone_num
    @password = password
  end

  def register
    begin
      connection = PG.connect(dbname: 'your_database_name', user: 'your_username', password: 'your_password')
      query = "INSERT INTO users (name, email, phone_number, password) VALUES ($1, $2, $3, $4)"
      values = [@name, @email, @phone_num, @password]
      connection.exec_params(query, values)

      "User registration successful!"
    rescue PG::Error => e
      "An error occurred during registration: #{e.message}"
    ensure
      connection&.close
    end
  end
end

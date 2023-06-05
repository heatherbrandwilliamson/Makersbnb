require 'pg'
require_relative 'user'

class UserRepository
  def create(user)
    sql = INSERT INTO users (name, email, phone_number, password) VALUES ($1, $2, $3, $4);
    DatabaseConnection.exec_params(sql, [user.name, user.email, user.phone_number, user.password])
  end
end
  

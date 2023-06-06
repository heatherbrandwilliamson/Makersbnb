require 'pg'
require_relative 'user'
require 'bcrypt'

class UserRepository
  def create(user)
    password = BCrypt::Password.create(user.password)
    sql = 'INSERT INTO users (name, email, phone_number, password) VALUES ($1, $2, $3, $4);'
    DatabaseConnection.exec_params(sql, [user.name, user.email, user.phone_number, password])
  end

  def find_by_email(email)
    sql = 'SELECT id, name, email, phone_number, password FROM users WHERE email = $1;'
   
    result_set = DatabaseConnection.exec_params(sql, [email])
    if result_set.num_tuples == 0
      return nil
    else
      user = User.new
      user.id = result_set[0]['id']
      user.name = result_set[0]['name']
      user.email = result_set[0]['email']
      user.password = result_set[0]['password']
      return user
    end
  end

  # def read(email)
  # end
end
  

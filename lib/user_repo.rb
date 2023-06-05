require 'pg'
require_relative 'user'


class UserRepository
  def initialize(name, email, phone_num, password)
    @name = name
    @email = email
    @phone_num = phone_num
    @password = password
  end

  

# require 'bcrypt'

# class User < ActiveRecord::Base
#   has_email :email
#   has_secure_password :password
  
#   validates :email, :presence => true, :uniqueness => true

#   def login(email, password)
#     user = User.find_by(:email => params[:email])
#     if user && user.authenticate(params[:password])
#       sessions[:email] = user.email
#     else
#       redirect '/login'
#     end
#   end
# end
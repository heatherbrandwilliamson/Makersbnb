require 'user_repo'

def reset_db
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({host: '127.0.0.1', dbname: 'makersbnb_test'})
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do
    reset_db
  end

  describe "#create" do
    it "creates a new User" do
      user = User.new()
      user.name = "Bob"
      user.email = "bob@bobmail.com"
      user.phone_number = "1234567890"
      user.password = "password"
      
      repo = UserRepository.new
      repo.create(user)
    end
  end
end





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
      user.name = "Jane"
      user.email = "jane@example.com"
      user.phone_number = "07700123456"
      user.password = "pass"
      
      repo = UserRepository.new
      repo.create(user)
    end
  end

  describe "#check to see if email already provided matches database" do
    it "checks email against database" do
      repo = UserRepository.new
      result = repo.find_by_email("jane@example.com")
      expect(result.email).to eq("jane@example.com")
    end
  end

    it "checks email and password against database" do
      repo = UserRepository.new
      result = repo.find_by_email("jane@example.com")
      expect(BCrypt::Password.new(result.password)).to eq("pass")
  end
end






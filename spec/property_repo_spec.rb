require 'property_repository'

def reset_db
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe PropertyRepository do
  before(:each) do 
    reset_db
  end

  describe "#create" do
    it "creates a new Property" do
      property = instance_double("Property", property_name: "House on the Hill", price: 150, location: "London", description: "This is a lovely house.", user_id: 1)
      repo = PropertyRepository.new
      repo.create(property)
      
      # expect(repo.all.last.property_name).to eq("House on the Hill")
    end
  end
end
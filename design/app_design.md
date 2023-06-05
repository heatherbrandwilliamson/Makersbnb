# MakersBnB Model and Repository Classes Design Recipe

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_chitter.sql)

-- TRUNCATE TABLE makers, peeps RESTART IDENTITY; -- replace with your own table name.

-- -- Below this line there should only be `INSERT` statements.
-- -- Replace these statements with your own seed data.

-- INSERT INTO makers (name, email, password) VALUES ('Sean', 'sean@makers.tech', '$2y$10$uqkMrjDvWYNeLR/zXgdnQOJsAqNEn8xa789LeBKafA0H4uIxou5gC');
-- INSERT INTO makers (name, email, password) VALUES ('Joe', 'joe@makers.tech', '$2y$10$izoz6TGIHKc3xjju0cXjn.N4QJEQvcdMs5s1ZAYZpzy/rrhPeaHLq');
-- INSERT INTO makers (name, email, password) VALUES ('Yevhen', 'yevhen@makers.tech', '$2y$10$xkywp3MGsLUkWi3eN5KEEuW2VcMZ/Rhdj5m70Yg3qLwwIwO0qZP8m');

-- INSERT INTO peeps (content, time, maker_id) VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', '2023-03-08 04:05:06');
-- INSERT INTO peeps (content, time, maker_id) VALUES ('Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', '2023-05-06 10:11:12');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 chitter_test < seeds_chitter.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: users

# Model class
# (in lib/user.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end
```
```ruby
# Table name: properties

# Model class
# (in lib/property.rb)
class Property
end

# Repository class
# (in lib/property_repository.rb)
class PropertyRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: users

# Model class
# (in lib/user.rb)

class User
  attr_accessor :id, :name, :email, :password, :phone_number
end
```

```ruby
# Table name: properties

# Model class
# (in lib/properties.rb)

class Property
  attr_accessor :property_name, :location, :description, :price, :user_id
end
```

## 5. Define the Repository Class interface


```ruby
# Table name: users

# UserRepository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:

    # SELECT id, name, email, phone_number FROM users;
    
    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, email, password, phone_number FROM users WHERE id = $1;

    # Returns a single User object.
  end

  # Creates a new record
  # One argument: a User object
  def create(User)
    # Executes the SQL query:
    # INSERT INTO users (name, email, password, phone_number) VALUES($1, $2, $3, $4);

    # Returns nothing
  end

end
```


```ruby
# Table name: properties

# Property class
# (in lib/property_repository.rb)

class PropertyRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, property_name, location, description, price, user_id FROM properties;

    # Returns an array of Property objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, property_name, location, description, price, user_id FROM properties WHERE id = $1;

    # Returns a single Property object.
  end

  # Creates a new record
  # One argument: a Property object
  def create(property)
    # Executes the SQL query:
    # INSERT INTO properties (property_name, location, description, price, user_id) VALUES($1, $2, $3, $4, $5);

    # Returns nothing
  end
  
end
```

## 6. Write Test Examples


```ruby

# 1
# Get all Makers

GET /makers
# Expected response: 200
# A list of Makers

repo = MakerRepository.new

makers = repo.all

makers.length # =>  3

makers[0].id # =>  1
makers[0].name # =>  'Sean'
makers[0].email # =>  'sean@makers.tech'



```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/user_repo_spec.rb

def reset_db
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe PropertyRepository do
  before(:each) do 
    reset_db
  end

  # (your tests will go here).
end
```


----

```ruby
# EXAMPLE ROUTE TESTS
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/posts?id=1')

      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end
```

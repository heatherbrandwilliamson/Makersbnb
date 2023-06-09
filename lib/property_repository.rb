require_relative 'property'

class PropertyRepository
  def create(property)
    sql = 'INSERT INTO properties (property_name, location, description, price, user_id) VALUES($1, $2, $3, $4, $5);'
    DatabaseConnection.exec_params(sql, [property.property_name, property.location, property.description, property.price, property.user_id])
  end

  def find(id)
    sql = 'SELECT id, property_name, location, description, image_url, price, user_id FROM properties WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])
    property = Property.new
    property.id = result_set[0]['id'].to_i
    property.property_name = result_set[0]['property_name']
    property.location = result_set[0]['location']
    property.description = result_set[0]['description']
    property.price = result_set[0]['price']
    property.user_id = result_set[0]['user_id']
    property.image_url = result_set[0]['image_url']
    return property
  end

  def all
    sql = 'SELECT id, property_name, location, description, image_url, price, user_id FROM properties;'
    result_set = DatabaseConnection.exec_params(sql, [])

    properties = []
    
    # The result set is an array of hashes.
    # Loop through it to create a model
    # object for each record hash.
    result_set.each do |record|

      # Create a new model object
      # with the record data.
      property = Property.new
      property.id = record['id'].to_i
      property.property_name = record['property_name']
      property.location = record['location']
      property.description = record['description']
      property.price = record['price']
      property.user_id = record['user_id']
      property.image_url = record['image_url']

      properties << property
    end

    return properties

  
  end
  



end

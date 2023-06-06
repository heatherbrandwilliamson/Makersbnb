require_relative 'property'

class PropertyRepository
  def create(property)
    sql = 'INSERT INTO properties (property_name, location, description, price, user_id) VALUES($1, $2, $3, $4, $5);'
    DatabaseConnection.exec_params(sql, [property.property_name, property.location, property.description, property.price, property.user_id])
  end

  def find(id)
    sql = 'SELECT id, property_name, location, description, price, user_id FROM properties WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])
    property = Property.new
    property.id = result_set[0]['id'].to_i
    property.property_name = result_set[0]['property_name']
    property.location = result_set[0]['location']
    property.description = result_set[0]['description']
    property.price = result_set[0]['price']
    property.user_id = result_set[0]['user_id']
    return property
  end
end
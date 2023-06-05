class PropertyRepository
  def create(property)
    sql = 'INSERT INTO properties (property_name, location, description, price, user_id) VALUES($1, $2, $3, $4, $5);'
    DatabaseConnection.exec_params(sql, [property.property_name, property.location, property.description, property.price, property.user_id])
  end
end
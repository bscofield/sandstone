module Factory
  
  def self.create_user!(attributes = {})
    default_attributes = {
      :login => 'tester',
      :email => 'test@example.com',
      :password => 'tester',
      :password_confirmation => 'tester'
    }
    User.create! default_attributes.merge(attributes)
  end

end
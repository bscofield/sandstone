module Factory
  
  def self.create_audit!(attributes = {})
    default_attributes = {
      # :key => 'value'
    }
    Audit.create! default_attributes.merge(attributes)
  end

end
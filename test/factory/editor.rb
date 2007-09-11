module Factory
  
  def self.create_editor!(attributes = {})
    default_attributes = {
      # :key => 'value'
    }
    Editor.create! default_attributes.merge(attributes)
  end

end
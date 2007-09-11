module Factory
  
  def self.create_page_template!(attributes = {})
    default_attributes = {
      :name => 'Test Template'
    }
    PageTemplate.create! default_attributes.merge(attributes)
  end

end
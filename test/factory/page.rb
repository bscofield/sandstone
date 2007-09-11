module Factory
  
  def self.create_page!(attributes = {})
    default_attributes = {
      :path => '',
      :title => 'Test Page',
      :content => 'test',
      :parent_id => nil
    }
    Page.create! default_attributes.merge(attributes)
  end

end
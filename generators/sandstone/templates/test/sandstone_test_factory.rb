module Sandstone
  module TestFactory
       
    def create_audit!(attributes = {})
      default_attributes = {
        # :key => 'value'
      }
      Audit.create! default_attributes.merge(attributes)
    end
    
    def create_editor!(attributes = {})
      default_attributes = {
        # :key => 'value'
      }
      Editor.create! default_attributes.merge(attributes)
    end

    def create_page!(attributes = {})
      default_attributes = {
        :path => '',
        :title => 'Test Page',
        :content => 'test',
        :parent_id => nil
      }
      Page.create! default_attributes.merge(attributes)
    end

    def create_page_template!(attributes = {})
      default_attributes = {
        :name => 'Test Template'
      }
      PageTemplate.create! default_attributes.merge(attributes)
    end
  end
end
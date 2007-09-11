class CreatePageTemplates < ActiveRecord::Migration
  def self.up
    create_table :page_templates do |page_templates_table|
      page_templates_table.with_options :null => false do |t|
        t.string :name
        t.text :content
        t.datetime :created_at, :updated_at
        t.datetime :deleted_at, :null => true
      end
    end
    
    PageTemplate.create_versioned_table
  end

  def self.down
    PageTemplate.drop_versioned_table
    drop_table :page_templates
  end
end

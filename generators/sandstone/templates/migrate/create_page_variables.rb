class CreatePageVariables < ActiveRecord::Migration
  def self.up
    create_table :page_variables do |page_variables_table|
      page_variables_table.with_options  :null => false do |t|
        t.integer  :page_id
        t.string   :name,       :limit => 32
        t.text     :content
        t.datetime :created_at, :updated_at
        t.datetime :deleted_at, :null => true
      end
    end
    
    add_index :page_variables, :page_id
    
    # version this? PageVariable.create_versioned_table
  end

  def self.down
    # PageVariable.drop_versioned_table
    drop_table :page_variables
  end
end

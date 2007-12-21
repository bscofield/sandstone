class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |pages_table|
      pages_table.with_options  :null => false do |t|
        t.integer  :parent_id, :page_template_id, :editor_id, :null => true
        t.string   :status,  :limit => 32, :default => 'new'
        t.string   :path,    :limit => 255
        t.string   :title,   :limit => 255, :null => true
        t.text     :content, :summary, :meta_description, :meta_keywords, :null => true
        t.datetime :created_at, :updated_at
        t.datetime :active_at, :expires_at, :deleted_at, :null => true
      end
    end
    
    add_index :pages, :path, :unique => true
    add_index :pages, :parent_id
    add_index :pages, :editor_id
    add_index :pages, :status
    
    Page.create_versioned_table
  end

  def self.down
    Page.drop_versioned_table
    drop_table :pages
  end
end

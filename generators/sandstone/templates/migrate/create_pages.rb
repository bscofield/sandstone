class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |pages_table|
      pages_table.with_options  :null => false do |t|
        t.integer  :parent_id,        :null => true
        t.integer  :page_template_id, :null => true
        t.integer  :editor_id,        :null => true
        t.string   :status,           :default => 'new'
        t.string   :path
        t.string   :title,            :null => true
        t.text     :content,          :null => true
        t.text     :meta_description, :null => true
        t.text     :meta_keywords,    :null => true
        t.datetime :active_at,        :null => true
        t.datetime :expires_at,       :null => true
        t.datetime :created_at
        t.datetime :updated_at
        t.datetime :deleted_at,       :null => true
      end
    end
    
    add_index :pages, :parent_id
    add_index :pages, :path, :unique => true
    add_index :pages, :editor_id
    
    Page.create_versioned_table
  end

  def self.down
    Page.drop_versioned_table
    drop_table :pages
  end
end

class CreateEditors < ActiveRecord::Migration
  def self.up
    create_table :editors do |editors_table|
      editors_table.with_options :null => false do |t|
        t.integer  :user_id
        t.string   :role, :limit => 32
        t.datetime :created_at, :updated_at
        t.datetime :deleted_at, :null => true
      end
    end
    
    add_index :editors, :user_id, :unique => true
    add_index :editors, :role
  end

  def self.down
    drop_table :editors
  end
end

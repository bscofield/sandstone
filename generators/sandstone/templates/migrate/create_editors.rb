class CreateEditors < ActiveRecord::Migration
  def self.up
    create_table :editors do |editors_table|
      editors_table.with_options :null => false do |t|
        t.integer  :user_id
        t.string   :user_type
        t.string   :role
        t.datetime :created_at, :updated_at
        t.datetime :deleted_at, :null => true
      end
    end
    
    add_index :editors, [:user_id, :user_type], :unique => true
  end

  def self.down
    drop_table :editors
  end
end

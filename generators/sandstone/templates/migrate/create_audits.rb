class CreateAudits < ActiveRecord::Migration
  def self.up
    create_table :audits do |audits_table|
      audits_table.with_options :null => false do |t|
        t.integer  :editor_id
        t.integer  :record_id,   :null => true
        t.string   :record_type, :null => true
        t.string   :event
        t.string   :details,     :null => true
        t.datetime :created_at
        t.datetime :deleted_at,  :null => true
      end
    end
    
    add_index :audits, [:record_id, :record_type]
    add_index :audits, :event
    add_index :audits, :editor_id
    add_index :audits, :created_at
  end

  def self.down
    drop_table :audits
  end
end

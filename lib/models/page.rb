class Page < ActiveRecord::Base
  STATUSES = ['new', 'pending', 'published']
  
  acts_as_versioned
  acts_as_tree
  
  has_many :audits, :as => :record, :dependent => :destroy
  belongs_to :page_template
  belongs_to :editor
  validates_uniqueness_of :path
  validates_presence_of :status, :content

  def layout
    page_template ? page_template.name.tableize : 'public'
  end

  def draft=(value)
    self.status = 'new'
  end
  
  def approve=(value)
    self.status = 'pending'
  end
  
  def publish=(value)
    self.status = 'published'
  end
  
  def self.find_roots
    find(:all, :conditions => {:parent_id => nil}, :include => :page_template)
  end
  
  def self.find_pending
    find_all_by_status('pending')
  end
end

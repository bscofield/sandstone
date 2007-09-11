class PageTemplate < ActiveRecord::Base
  LAYOUT_PATH = "#{File.dirname(__FILE__)}/../views/layouts"
  acts_as_versioned
  
  has_many :pages, :dependent => :nullify
  has_many :audits, :as => :record, :dependent => :destroy
    
  after_save :create_file_on_filesystem
  after_destroy :remove_file_from_filesystem
  
  validates_presence_of :name
  validates_uniqueness_of :name

  private
  def layout_filename 
    "#{LAYOUT_PATH}/#{name.tableize}.html.erb"
  end

  def create_file_on_filesystem
    File.open(layout_filename, 'wb+') do |file|
      file.puts content
    end
  end
  
  def remove_file_from_filesystem
    File.delete layout_filename
  end
end

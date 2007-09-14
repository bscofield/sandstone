class PageTemplate < ActiveRecord::Base
  LAYOUT_PATH = "#{File.dirname(__FILE__)}/../views/layouts"

  include Sandstone::Models::PageTemplate
end
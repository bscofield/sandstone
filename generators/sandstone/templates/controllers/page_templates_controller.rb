class PageTemplatesController < ApplicationController
  include Sandstone::PageTemplateSystem
  
  before_filter :require_sandstone_editor, :except => :show
end

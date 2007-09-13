class EditorsController < ApplicationController
  layout 'sandstone'
  include Sandstone::Controllers:Editors
  
  before_filter :require_sandstone_manager, :except => :show
  before_filter :require_sandstone_editor, :only => :show
end

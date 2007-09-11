class EditorsController < ApplicationController
  layout 'sandstone'
  include Sandstone::EditorSystem
  
  before_filter :require_sandstone_manager, :except => :show
  before_filter :require_sandstone_editor, :only => :show
end

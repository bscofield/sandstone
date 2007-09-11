class EditorsController < ApplicationController
  include Sandstone::EditorSystem
  
  before_filter :require_sandstone_manager, :except => :show
  before_filter :require_sandstone_editor, :only => :show
end

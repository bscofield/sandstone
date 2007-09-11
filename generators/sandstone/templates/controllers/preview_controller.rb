class PreviewController < ApplicationController
  layout 'public'
  include Sandstone::PreviewSystem
  
  before_filter :require_sandstone_editor
end

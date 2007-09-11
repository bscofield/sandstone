class PreviewController < ApplicationController
  include Sandstone::PreviewSystem
  
  before_filter :require_sandstone_editor
end

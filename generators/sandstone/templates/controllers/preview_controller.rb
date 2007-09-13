class PreviewController < ApplicationController
  layout 'public'
  include Sandstone::Controllers::Preview
  
  before_filter :require_sandstone_editor
end

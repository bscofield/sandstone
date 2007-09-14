class PreviewsController < ApplicationController
  layout 'public'
  include Sandstone::Controllers::Previews
  
  before_filter :require_sandstone_editor
end

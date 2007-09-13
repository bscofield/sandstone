class PagesController < ApplicationController
  layout 'sandstone'
  include Sandstone::Controllers::Pages
  
  before_filter :require_sandstone_editor, :except => [:show, :destroy]
  before_filter :require_sandstone_manager, :only => :destroy
  around_filter :authorize_sandstone_editor, :only => [:edit, :update]
end

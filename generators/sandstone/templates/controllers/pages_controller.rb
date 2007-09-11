class PagesController < ApplicationController
  layout 'sandstone'
  include Sandstone::PageSystem
  
  before_filter :require_sandstone_editor, :except => [:show, :destroy]
  before_filter :require_sandstone_manager, :only => :destroy
  around_filter :authorize_sandstone_editor, :only => [:edit, :update]
end

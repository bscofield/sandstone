class AuditsController < ApplicationController
  layout 'sandstone'
  include Sandstone::Controllers::Audits
  
  before_filter :require_sandstone_manager
end

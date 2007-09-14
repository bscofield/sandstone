class Page < ActiveRecord::Base
  EXPLICIT_ROUTES = ActionController::Routing::Routes.routes.inject([]) { |array, r| array << r.segments.inject("") { |str,s| str << s.to_s }}
  
  include Sandstone::Models::Page
end
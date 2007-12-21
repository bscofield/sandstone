class Editor < ActiveRecord::Base
  include Sandstone::Models::Editor
  
  belongs_to :user, :class_name => "User" # replace with the appropriate class name
end
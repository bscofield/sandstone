require 'test_helper'
require 'rubygems'
require 'mocha'
require 'tester_xtreme'
require File.dirname(__FILE__) + '/sandstone_test_factory'
include Sandstone::TestFactory

# Re-raise controller errors
class ApplicationController < ActionController::Base
  def rescue_action(e)
    raise e
  end
end
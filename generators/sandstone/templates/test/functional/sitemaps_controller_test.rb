require File.dirname(__FILE__) + '/../sandstone_test_helper'
require 'sitemaps_controller'

# Re-raise errors caught by the controller.
class SitemapsController; def rescue_action(e) raise e end; end

class SitemapsControllerTest < Test::Unit::TestCase
  def setup
    @controller = SitemapsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

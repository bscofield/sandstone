require File.dirname(__FILE__) + '/../sandstone_test_helper'
require 'previews_controller'

# Re-raise errors caught by the controller.
class PreviewsController; def rescue_action(e) raise e end; end

class PreviewsControllerTest < Test::Unit::TestCase
  def setup
    @controller = PreviewsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

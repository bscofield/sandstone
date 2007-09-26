require File.dirname(__FILE__) + '/../sandstone_test_helper'
require 'editors_controller'

# Re-raise errors caught by the controller.
class EditorsController; def rescue_action(e) raise e end; end

class EditorsControllerTest < Test::Unit::TestCase
  def setup
    @controller = EditorsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

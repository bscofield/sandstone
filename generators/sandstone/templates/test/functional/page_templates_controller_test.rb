require File.dirname(__FILE__) + '/../sandstone_test_helper'
require 'page_templates_controller'

# Re-raise errors caught by the controller.
class PageTemplatesController; def rescue_action(e) raise e end; end

class PageTemplatesControllerTest < Test::Unit::TestCase
  def setup
    @controller = PageTemplatesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

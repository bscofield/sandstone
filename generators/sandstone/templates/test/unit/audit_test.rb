require File.dirname(__FILE__) + '/../sandstone_test_helper'

module UnitTest

  class AuditTest < Test::Unit::TestCase
    should_belong_to :editor
    should_require :event, :editor_id
  end

end
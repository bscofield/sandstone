require File.dirname(__FILE__) + '/../test_helper'

module UnitTest

  class AuditTest < Test::Unit::TestCase
    should_belong_to :editor
    should_require :event, :editor_id
  end

end
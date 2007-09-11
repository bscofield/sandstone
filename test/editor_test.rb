require File.dirname(__FILE__) + '/../test_helper'

module UnitTest

  class EditorTest < Test::Unit::TestCase
    should_require :user_id
    should_require_unique :user_id
#    should_belong_to :user
    should_have_many :pages, :audits
  end

end
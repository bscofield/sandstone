require File.dirname(__FILE__) + '/../sandstone_test_helper'

module FunctionalTest

  class PageTemplateTest < Test::Unit::TestCase
    should_have_many :pages
    should_require :name
    should_require_unique :name

    # hits the database, mocks the filesystem
    def test_file_should_be_created_with_record
      template = PageTemplate.new :name => 'tester'
      File.expects(:open).with(template.send(:layout_filename), 'wb+')
      template.save
    end
  end
end

require File.dirname(__FILE__) + '/../test_helper'

module UnitTest

  class PageTest < Test::Unit::TestCase
    should_have_many :audits
    should_belong_to :page_template
    should_belong_to :editor
    should_require_unique :path
    should_require :content

    def test_layout_should_default_to_application
      Page.any_instance.stubs(:page_template).returns(nil)
      assert_equal 'public', Page.new.layout
    end
    
    def test_layout_should_derive_from_template
      template = stub(:name => 'test')
      Page.any_instance.stubs(:page_template).returns(template)
      assert_equal 'tests', Page.new.layout
    end

    def test_status_defaults_to_new
      assert_equal 'new', Page.new.status
    end
    
    def test_find_pending_should_call_dynamic_finder
      Page.expects(:find_all_by_status).with('pending')
      pages = Page.find_pending
    end
    
    def test_assigning_to_approve_sets_status
      page = Page.new
      page.approve = true
      assert_equal 'pending', page.status
    end

    def test_assigning_to_draft_sets_status
      page = Page.new
      page.draft = true
      assert_equal 'new', page.status
    end

    def test_assigning_to_publish_sets_status
      page = Page.new
      page.publish = true
      assert_equal 'published', page.status
    end
  end

end
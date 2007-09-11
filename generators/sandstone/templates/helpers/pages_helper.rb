module PagesHelper
  include SandstoneHelper
  
  def parent_pages_for(page)
    pages = Page.find(:all, :select => 'id, title').map {|p| [p.title, p.id]}
    pages.reject {|p| p[1] == page.id} unless page.new_record?
    pages
  end
  
  def templates
    PageTemplate.find(:all, :select => 'id, name').map {|p| [p.name, p.id]}
  end
  
  def status_icon(page)
    case page.status
      when 'new'
        '*'
      when 'pending'
        '-'
      when 'published'
        ''
    end
  end
  
  def editor_link_to(page, *args)
    if editor.can_edit? page
      link_to *args
    else
      args.first
    end
  end
  
  def manager_link_to(*args)
    if editor.manager?
      link_to *args
    else
      args.first
    end
  end
end

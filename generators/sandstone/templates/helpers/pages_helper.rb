module PagesHelper
  include SandstoneHelper

  def parent_pages_for(page)
    conditions = page.new_record? ? nil : ['id != ?', page.id]
    pages = Page.find(:all, :select => 'id, title', :conditions => conditions).map {|p| [p.title, p.id]}
    [['none', '']] + pages
  end

  def editors_for(page)
    editors = Editor.find(:all).map {|e| [e.user.name, e.id]}
    [['none', '']] + editors
  end

  def versions_for(page)
    versions_array = page.versions.map do |v| 
      text = "#{status_icon(v)} v#{v.version} - #{v.updated_at.to_s(:short)}"
      [text, v.version]
    end.reverse
    options_for_select(versions_array, page.version)
  end

  def templates
    available = [['default', '']]
    templates = PageTemplate.find(:all, :select => 'id, name').map {|p| [p.name, p.id]} 
    available = templates.empty? ? available : available + templates
  end

  def status_icon(page)
    status = case page.status
    when 'new'
      '*'
    when 'pending'
      '-'
    when 'published'
      ''
    end

    status += 'E' if page.expires_at? && page.expires_at < Time.now
    status
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

module SitemapsHelper
  def render_children(parent)
    page = parent.is_a?(Page::Version) ? parent.page : parent
    content_tag :ul, (render(:partial => 'sitemaps/detail', :collection => page.children)) unless page.children.empty?
  end
end
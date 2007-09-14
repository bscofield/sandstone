module Sandstone
  module Controllers
    module Sitemaps
      def show
        @pages = Page.find_roots(true)
      end
    end
  end
end
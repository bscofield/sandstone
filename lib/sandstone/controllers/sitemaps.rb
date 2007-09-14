module Sandstone
  module Controllers
    module Sitemaps
      def show
        @pages = Page.find_roots
      end
    end
  end
end
module Sandstone
  module Controllers
    module Previews
      def create
        @page = Page.new(params[:page])
        template = !params[:page][:page_template_id].blank? ?
        PageTemplate.find(params[:page][:page_template_id]).name.tableize : 
        @page.layout

        render :template => 'pages/show', :layout => template
      end
    end
  end
end

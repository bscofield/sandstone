module Sandstone
  module Controllers
    module Pages

      def index
        @page_title = 'Pages'
        @pages = Page.find_roots
      end

      def show
        @page = Page.find_by_path(params[:path].join('/')) 
        current = @page.versions.find_by_status('published', :order => 'version DESC',
          :conditions => ['(active_at IS NULL AND expires_at IS NULL) OR (active_at IS NULL and expires_at >= ?) OR (active_at <= ? AND expires_at IS NULL) OR (? BETWEEN active_at AND expires_at)', Time.now, Time.now, Time.now]
        ) if @page
        
        if current
          @page.revert_to(current.version)
          render :layout => @page.layout
        else
          @page = Page.new
          render :template => 'pages/page_not_found', :status => 404, :layout => 'public'
        end
      end

      def new
        @page_title = 'Create a Page'
        @page = Page.new(:parent_id => params[:parent_id])
      end

      def edit
        @page_title = 'Edit a Page'
        if params[:version]
          @page.revert_to(params[:version])
        else
          @page.load_content_from_filesystem
        end
      end

      def create
        @page = Page.new(params[:page].merge(:editor => editor))

        if @page.save
          Audit.log('create', editor, @page)
          
          flash[:notice] = Page::EXPLICIT_ROUTES.include?("/#{@page.path}") ? 
            'Path already exists in system - page was created for sitemap only' :
            'Page was successfully created.'
          redirect_to workspace_path
        else
          render :action => "new"
        end
      end

      def update
        @page = Page.find(params[:id])
        page_params = params[:page]
        page_params.merge(:editor => editor) unless page_params[:editor_id]
        
        if @page.update_attributes(page_params)
          Audit.log('update', editor, @page)

          flash[:notice] = Page::EXPLICIT_ROUTES.include?("/#{@page.path}") ? 
            'Path already exists in system - page was updated for sitemap only' :
            'Page was successfully updated.'
          redirect_to workspace_path
        else
          render :action => "edit" 
        end
      end

      def destroy
        @page = Page.find(params[:id])
        Audit.log('destroy', editor, nil, "#{@page.title} (#{@page.path}) destroyed")
        @page.destroy

        redirect_to workspace_path
      end
    end
  end
end
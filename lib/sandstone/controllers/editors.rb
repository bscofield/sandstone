module Sandstone
  module Controllers
    module Editors
      def show
        @page_title = 'Workspace'
        @pages = editor.pages
        @pending_pages = Page.find_pending if editor.manager?
      end

      def index
        @page_title = 'Editors'
        @editors = Editor.find(:all)
      end

      def new
        @page_title = 'Create an Editor'
        @editor = Editor.new
      end

      def edit
        @page_title = 'Edit an Editor'
        @editor = Editor.find(params[:id])
      end

      def create
        @editor = Editor.new(params[:editor])

        if @editor.save
          Audit.log('create', editor, @editor)
          flash[:notice] = 'Editor was successfully created.'
          redirect_to editors_path
        else
          render :action => "new"
        end
      end

      def update
        @editor = Editor.find(params[:id])

        if @editor.update_attributes(params[:editor])
          Audit.log('update', editor, @editor)
          flash[:notice] = 'Editor was successfully updated.'
          redirect_to editors_path
        else
          render :action => "edit" 
        end
      end

      def destroy
        @editor = Editor.find(params[:id])
        Audit.log('destroy', editor, nil, "#{@editor.user.login} editorial role destroyed")
        @editor.destroy

        redirect_to(editors_url)
      end
    end
  end
end
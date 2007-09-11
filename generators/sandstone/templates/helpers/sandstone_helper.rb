module SandstoneHelper
  def editor
    logged_in? && current_user ? current_user.editor : nil
  end

  private
  def require_sandstone_editor
    if !logged_in? || !editor
      flash[:notice] = 'You must be logged in as an editor for that'
      access_denied
      false
    end
  end

  def require_sandstone_manager
    if !logged_in? || !editor || !editor.manager?
      flash[:notice] = 'You must be logged in as a manager for that'
      access_denied
      false
    end
  end

  def authorize_sandstone_editor
    @page = Page.find(params[:id])
    if editor.can_edit? @page
      yield
    else
      flash[:notice] = 'You are not authorized to edit that page'
      redirect_to pages_path
    end
  end
end
module SandstoneHelper
  def editor
    logged_in? && current_user ? current_user.editor : nil
  end
end
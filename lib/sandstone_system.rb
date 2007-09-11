module SandstoneSystem
  protected
  def editor
    Editor.find_by_user_id(current_user.id) if current_user
  end
end
module EditorsHelper
  def potential_editors
    User.find(:all, :select => 'id, login').map {|u| [u.login, u.id]}
  end
end

module EditorsHelper
  # TODO: incorrectly assumes presence of a User model
  def potential_editors
    User.find(:all, :select => 'id, login').map {|u| [u.login, u.id]}
  end
end

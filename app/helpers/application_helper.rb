module ApplicationHelper

  def current_company
    current_user.company
  end

  def user_name_and_avatar(user)
    raw("<img class='silouhette' width='28px' src='/silouhette.png' /><span>#{user.first_name} #{user.last_name}</span>")
  end
  
end

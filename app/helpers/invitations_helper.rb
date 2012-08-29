module InvitationsHelper
  def already_invited(user,event)
    return nil if user==nil
    Invitation.where("user_id = ?", user.id).where("event_id = ?",event.id).first
  end

  def users_that_can_be_invited(event)
    return nil if event==nil
    reserved_users=event.reservations.map { |u| u.user_id }
    invited_users=event.invitations.map { |u| u.user_id }
    x= (reserved_users+invited_users).uniq.join(",")
    if x.blank?
    User.all
    else
    User.find_by_sql("select users.* from users where users.id NOT IN (#{x})")
    end
  end
end

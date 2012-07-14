module GroupsHelper
  def already_interested?(user,group)
    return nil if user==nil
    Interest.where("user_id = ?", user.id).where("group_id = ?",group.id).first
  end
end

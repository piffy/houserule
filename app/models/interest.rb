class Interest < ActiveRecord::Base
  attr_accessible :is_banned, :gets_email, :group_id, :user_id, :is_visible
end

class Interest < ActiveRecord::Base
  attr_accessible :is_banned, :gets_email, :group_id, :user_id, :is_visible
  belongs_to :group
  belongs_to :user
  validates_presence_of :user_id
  validates_presence_of :group_id
  validates :is_banned, :inclusion => {:in => [true, false]}
  validates :gets_email, :inclusion => {:in => [true, false]}
  validates :is_visible, :inclusion => {:in => [true, false]}
end

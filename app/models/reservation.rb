#This class represents a reservation to a given Event by a given User
#Classic n:m relationship.Has status, but unused in 0.1
class Reservation < ActiveRecord::Base
  attr_accessible :event_id, :status, :user_id
  belongs_to :event
  belongs_to :user
  validates :status, :numericality => true
  validates_presence_of :user_id
  validates_presence_of :event_id

end

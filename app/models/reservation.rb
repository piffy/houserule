class Reservation < ActiveRecord::Base
  attr_accessible :event_id, :status, :user_id
  belongs_to :events
  belongs_to :users
  validates :status, :numericality => true
  validates_presence_of :user_id
  validates_presence_of :event_id

end

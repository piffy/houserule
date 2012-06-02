class Reservation < ActiveRecord::Base
  attr_accessible :event_id, :status, :user_id
  belongs_to :events
  belongs_to :users
  validates :status, :numericality => true

end
